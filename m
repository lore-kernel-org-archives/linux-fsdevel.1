Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67032F9985
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417561; cv=none; b=LmxFAP5Q5gI4OC1l2UAF7Z7hXT2QVHfDIn4uvZ4S6QIudN7fGLymEeCYpMWOrDToCy4A/XVSdbz2FqtQoCHM3o4DvIZlAVLueo/sFoFDyuk/EYhPJ0npLcZqCdhH5j5y4fTmG/1K2C+6CIWZ0/lyGKPd0wfn1bBsKU3dzc4IAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417561; c=relaxed/simple;
	bh=vBtlceh81EBRly2nwGp4pbLnqkxyOo4vOEbYGLFUMsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJwdSr0fWKjFx+ohXlF43GB15zuGUFENZvRnLCTllPQNPFRtp1tnNOxLY3ZHdBxDqD4DNzZlDvjGo5Dker7tx0dHAlwDITxUNza3tItnK4adFqKA3Vv5cEzujfK8YXMMIy9fhr8aOtR37H9P5bMR/EQzqx9HCCgU17V1DzUfrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8Jw76FU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Jw76FU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1715393a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Apr 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417560; x=1776022360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBuFGDALcJeSyW255Y6h4kabjHqNu/KLOW1Xbqv4rHw=;
        b=V8Jw76FULq85zGdVH/0LlAnl1u+P96ldUr63RuKXzxscDtOX4cwdvlIQarrqKU1peC
         LlyXo8jB46Ns009wZnXFP69w7FuXEHrQYg4XlF4rW2yU6H4fwsTUhpGI8Dwwy0NIF7ls
         YGVGQsWtev5rOgn2V2sqG7ONhOLxpKZgOLDvbtAiyJj712JLJSA83MYhZH/9tD2HWpnY
         v8W5NtDRketu7gLb87uEA6IQu+h+TRFvatQjUJFyJoRG/SNeGr/He4LClIdshwMbFuJU
         2vFkoviNb1veEdgJKVFRNjIrUDnZrCQpT2iBstNRK5lDvFc7yKO22sB1yvlIl9xxVi5w
         yC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417560; x=1776022360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBuFGDALcJeSyW255Y6h4kabjHqNu/KLOW1Xbqv4rHw=;
        b=DnqF+6foPEmOENchlMIw9MZ+FlScdtSEcbSZKVC0kVJ8JzS+aT+9S4mWLWWDJjr9Aw
         z21qVcWwAZAhmhQkZ/8sH4ZxF4Ra2/eUcZVjnhNs0Z1REVLKZQWPAgECyi8AvagWAgpW
         oBkQg/N3wlZjS9twkmoOaBTSvU/H1N1QJHKGKROlNTGBSQEdKnc3lmczsHukVWiE0dV9
         lEbwyL7prHllcYDZlUJ/Xk+4GrExFVWiuuQwsI5+7NXnDfJHk8/jKtwr2FlEwhxHJVny
         34cGZdCLsRf5vowxYUQaPCW9oNOzPwm+eaxSpQWcFx+bJeKtnb2lC6nu2Tl6rTDqJ+9A
         +zLA==
X-Forwarded-Encrypted: i=1; AJvYcCUMg5B0jhva81WBCmE2tI58aRh3XYpOIpX0zJP+Mjmm1CqbuL8BBarIxyq7Z6AzpY8LtFhzq/g2zddfAbu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc93z8W/Ox02weRAoLuvjxw/X+0UigDBFgioZv4yq+67lXh3c
	BJMDexZZhdu0xl3n41lwA/cf+LSGx7OFi05NXpZmk8Y4ujfjpvSm8ICw
X-Gm-Gg: AeBDieuthPTnPWMBuvwPiHcHwEzoKlV3Vb/QJZBq1K34Oom9zDSwy/JZPoKiUmuB8TJ
	PzyX4ZG83XnZnspJ9OKMUX6f/86+dZX+2noSGDIF3BAETXURdxWBZYQV+Q2pEOXnKlpO9sgK/mV
	zIsat9MqIEYzJfoX6jGi8ZWEWm5rwu6jmIfQjmRWa3g14+tSLtG7Pw48dxU+SomHqN0C3u6qaBi
	VJAXzdHWybCdgpI9OSxPzD4tuPuxqPyHC287AdFsmM4ddWE3L2YpHjQHrX7FcFfn3Dtp66b2zNk
	e9QAxAWf4nVxUzwFKbu14cQtkM3R86Pl0m08BmtUv9q75HWbE+XZLJh/gyGEMP7uWGEla1L5u0x
	P2mrrJPMYIwipzhLUat+rVY/PvjvCO1Ox/EVr+n4v1hXTd6B+eyhCvryUSjGIdvGUiY8ZdiGaOf
	lN+kQnVG9A6yQ2zA==
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id 98e67ed59e1d1-35de6899ce5mr9686034a91.11.1775417559954;
        Sun, 05 Apr 2026 12:32:39 -0700 (PDT)
Received: from mes.. ([2001:288:3001:25:be24:11ff:fe8b:b59f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563aacsm10498601a12.19.2026.04.05.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 12:32:39 -0700 (PDT)
From: Yung-Tse Cheng <mes900903@gmail.com>
To: gmaglione@redhat.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Cc: eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yung-Tse Cheng <mes900903@gmail.com>
Subject: [PATCH] virtio-fs: avoid double-free on failed queue setup
Date: Mon,  6 Apr 2026 03:30:39 +0800
Message-ID: <20260405193039.178506-1-mes900903@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_fs_setup_vqs() allocates fs->vqs and fs->mq_map before calling
virtio_find_vqs(). If virtio_find_vqs() fails, the error path frees both
pointers and returns an error to virtio_fs_probe().

virtio_fs_probe() then drops the last kobject reference, and
virtio_fs_ktype_release() frees fs->vqs and fs->mq_map again. This leaves
dangling pointers in struct virtio_fs and can trigger a double-free during
probe failure cleanup.

Set fs->vqs and fs->mq_map to NULL immediately after kfree() in the
virtio_fs_setup_vqs() error path so that the later kobject release sees an
uninitialized state and kfree(NULL) becomes harmless.

Signed-off-by: Yung-Tse Cheng <mes900903@gmail.com>
---
This can be reproduced when a broken virtio-fs device advertises more
request queues than the transport actually provides. In that case
virtio_find_vqs() fails while setting up the extra queue, and the probe
path reaches the double-free cleanup sequence.

 fs/fuse/virtio_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 057e65b51b99d..e33241e1b8ad9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -988,7 +988,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	kfree(vqs);
 	if (ret) {
 		kfree(fs->vqs);
+		fs->vqs = NULL;
 		kfree(fs->mq_map);
+		fs->mq_map = NULL;
 	}
 	return ret;
 }

base-commit: 3aae9383f42f687221c011d7ee87529398e826b3
-- 
2.43.0

