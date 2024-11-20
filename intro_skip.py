Intro = 0x03c94d0d
Pre_classroom = 0x03c94d61
Classroom = 0x03c95203
#TutorialStart = 0x03c96eae
#TutorialStoryProgress = 0x03c9702f
PubStart = 0x03c9717c
PubStoryProgress = 0x03c976b1


def patch_intro(file_path):
    with open(file_path, "r+b") as f:
        f.seek(Intro)
        f.write(bytes([
            0x8f, 0x00, 0x00,
            0x09, 0x00, 0x3c,
            0x8f, 0x00, 0x01,
            0x09, 0x00, 0x3c,
            0x9c, 0x00,
            0x22, 0x00, 0x01, 0x00,
            0x1e, 0x00,
            ]))
        f.seek(Pre_classroom)
        f.write(bytes([
            0x1f, 0x00, 0x25, 0x00,
            ]))
        f.seek(Classroom)
        f.write(bytes([
            0x22, 0x00, 0x06, 0x00,  # 04 = tutorial, 05 = after tutorial, 06 = pub
            0x1e, 0x00,
            ]))
        # f.seek(TutorialStart)
        # f.write(bytes([
        #     0x1f, 0x00, 0x55, 0x01, 0x00, 0x00,
        #     ]))
        # f.seek(TutorialStoryProgress)
        # f.write(bytes([0xff, 0x05]))
        f.seek(PubStart)
        f.write(bytes([
            0x1f, 0x00, 0x06, 0x05, 0x00, 0x00,  # Originally 506
            ]))
        f.seek(PubStoryProgress)
        f.write(bytes([
            0xa6, 0x04,
            # 0x8e, 0x00, 0x00, 0x06,  # Adelle joins
            # 0x0c, 0x00, 0x0a,
            0x1e, 0x00,]))
