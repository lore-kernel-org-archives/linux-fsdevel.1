Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3138A73B
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262841; cv=none; b=JL1T8bEU+RzrjXCfXxEiEamlHDXGZsZtP9mkpUgC48C374nJEnyPxN/4K3oAlsDASqbwbHR1WjJ4+TdmwCoqtlXe2V8NuSdSZ7M+96QoJ/g+wf2LzH3Vq6XdJG1RhJhm8TfA4KBjxHtQktpk3kG5rJSUK0btlvWblr+hU7r6muI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262841; c=relaxed/simple;
	bh=P3hdtakuwRs8sGgX8SbTRg535OO9QDcChPnINsMgxSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrdByZk9QJfrMiLM50PvnbCHG+tz+xWkIab/9p9SY1bccv3vW6lZj4Y5cpc/XQ6SvdAhRi9CMWZfAlEdUyCpsTFB432k+7+Xp8e8unWtpl/gYJmWzsSiUXApd/7H02t1+PYoec3zHOKlSuWApTzGc1Us2M9cwU/0bZnCGLo/oQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7t5Zjwn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7t5Zjwn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d91518a63fso6225545ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262839; x=1788867639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbJYqMSdfBVb+Q8QcPC8voCv5rVOzcHLGQSLMYKXoJs=;
        b=Q7t5ZjwnMTl4U8MTQFe9FeEEbQfxsNXumEVXieQjXQVV+LMhjiPc8ZgZu4iqx1EzQ0
         QqSaEB884GtaVuF/QAwB7qA4SjV+qRR6/mhP5DAUeU+WSN08HV8tPf+CAu9K1CWGNNh6
         7qEGAxECy/VV1SFXATiCL5BB/6JR95IcOc8L3HeVzQt1DAdTcrHMP5i4mksng1rN75pw
         2/lKQAFdVH8bC9PlooAFIOVDKp9IjU+zEIkNclJJR1FCGewyI88To4fEr3nV/dyH9AvD
         KpxI0PiZECpY+3q2JLMi6mTJ4FHTHYwpb3PbcUPS9G4thtIiGpYKJt6eEN7go0yepQzL
         WuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262839; x=1788867639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbJYqMSdfBVb+Q8QcPC8voCv5rVOzcHLGQSLMYKXoJs=;
        b=VZWuO/c2/KF7dEuRy/A5DHbrDmLZMoBUwtpqhfAqVJiXEYWvvRnzOtKj8xIAlFBV74
         Yb+7OOozbJ+4oJTV6CD/DWBgM1gnb2G8MLt+yVEorTL1GYrf0jz1VjhsZ9z88xBGwQ4D
         KYrWj4ydWufpE+BMXOloB++avv0ZkuCzGqR3wSTWAixm0sFrucBXYjAIJhlS4FT6Z7Oq
         Kadqhk9EdTm56E2h0a4+lN468TC6smvsHDzECGUHGxdtFHuLUb8kbsKlIKcrpeBYkFyS
         ihIn1p2Ii0WJGVOjme/pDTMGm1XwDyTo8UGRuEgcCC9RilSsPD5F95WDrSyQBy3+MGKv
         XeTw==
X-Forwarded-Encrypted: i=1; AHgh+RoOxBiavIQ75eGGtX0cToJGvMtYYEl9cv4eUPBkJCiq3WtRoyTaLQ2LnIEm86Yni7cv8Hj9HCYp+aqO5vWw@vger.kernel.org
X-Gm-Message-State: AFuF++lwX5cHpYYwV5XOCMr8yAcWIgneyQ2Qde9u2Vr60HG2zJ5fPf+l
	9b5lUt69KmmIl+8B5q/0UpT/F/P9VeY68ZwPSYQnMW6D+oYkT7WMa+Sb
X-Gm-Gg: AYBFou3occ4SNGHa2fywBAzOoB9Ke9JlOrZjqbmuOVyX8ZFzogRwd/OQR1B+S9mb1WR
	63jaHpzVELAyk4hZkJhIGFXG3nk3jhKMruDTCR6VahgvaLANmQ+SOLX5tJkDwD1n05IRydfznsk
	JNIlBfhOsGzcvAz0e/JBlox1YaoHOsxSt3tOSCVEAdRByENxfUj2VYOtw+k2r1MLjMsiNv4z3Fo
	Qdjiz3xJcio8XpxJyNED3zxlgetU0/xIh1QwFaXL1i9mAbEpmY8vS9qooBbYBPsspDFG+f0rHPH
	H6g0f4cPch6/jm6NGCiwnZIioIr9yn1RNzjS5BawBEblifc12JQCaF1c33s7OXd/7+mihng9d3o
	3Q1sPQeMuFvd4p2DjD67D80LO30m+nvA3WtkYg4uvxBfTCRxbkZUI6TZavkwZSQP8ruxaBI3Vdf
	F2w7pixZgXjA0u8sIACiGPGe9kqnEwa+DAWxDLukmGttgNAMEQwZmQZ9ZjPngYMHQeEQHgp8I7d
	i2+N9AVXXhZpwxtvpKetYRx7ASu8bJ34pziZKtZ4fMl
X-Received: by 2002:a17:903:42cc:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d74e1386bcmr327790875ad.14.1788262838570;
        Tue, 01 Sep 2026 04:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100:1e0::500e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b6c7sm49316075ad.60.2026.09.01.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:40:38 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	tasos.papagiannnis@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf-next] exec: Drop bprm loader before closing bprm->file
Date: Tue,  1 Sep 2026 04:40:11 -0700
Message-ID: <20260901114011.112375-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_bprm() currently drops what may be the final reference to
bprm->file before calling bprm_drop_loader(). Since
bprm_drop_loader() is attachable via BPF fentry and bprm->file is
exposed as a BTF_TYPE_SAFE_TRUSTED pointer, the file can be observed
after its reference has been released.

Move bprm_drop_loader() before do_close_execat(bprm->file), keeping
the file reference held while the hook runs. This preserves the
existing trusted BTF contract without changing verifier behavior.

The loader file and bprm->file have independent references, so this
reordering does not change their required teardown ordering.

Link: https://sashiko.dev/#/patchset/20260831092305.42062-1-tasos.papagiannnis@gmail.com?part=3
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a14f28b15607..263b1f67f1f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1469,9 +1469,9 @@ static void free_bprm(struct linux_binprm *bprm)
 	/* exec swapped the mm but failed before setup_new_exec() freed it */
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
-	do_close_execat(bprm->file);
 	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
 	bprm_drop_loader(bprm);
+	do_close_execat(bprm->file);
 	do_close_execat(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)

base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.43.0

