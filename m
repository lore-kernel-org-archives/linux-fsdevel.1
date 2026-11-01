Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564275;
	b=Mz9fOqeuPauDHQH3TQWIxXM10UvkowGPVqUqgPRNXLcreBk3h1KXwTRULbwIC4sPH6jE
	 poqpeZmHl4e5NiX+qSIt7JXD2XA3rPXh1+uWI1/pQFL9c2RtEzNBD2+QVZ1sGsuLe5Odn
	 PqVluB+PFlLKAELjRR1sWB0euY9d+HZJePTq740ToQIsaSMAwmu306bYrXhAXiSAa/iAA
	 14Vs67luz7k4idIC6JCxnMQ4fzF8snh57I8yXgmXZd6ZwN8VmtnTw23porKHHuavzOV5F
	 wZahjYwvOfzMp9p9tBr2qyNQQwa0V+ZstFdldbfot/Ctc1NBcIbxiRLBL6xK3r1Wd4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IslZwScJ+AfRGcBpiL9dKDI16HL4dxngXHAAdwckctw=;
	b=PiRdCK77a++M/x6AFVHW2EBgTYpZITJy2UBUBRbgL3Ycf1iVtpzkXFaAVSrh1yiYyWaP
	 fEJUtnDjPHPix7KDnyl4dKoA/ZXWXsULdu47Ql3GnIRiGnXschxJXr/wwNZENVa4ZmHVu
	 d30eR3f/OhkqbEU0YdQ1cBFLeJljfT550SKMJFADysA9di3lua7UqjcDHh1wpdfN643MG
	 pT+Jwt2WIJNOUonc34nnF1CEf9wiJRu3zRmAB2goZQRzxQ0QiZIr2K4avZ3pD5KvXEb6o
	 L9NT+exPS3BcO3wHVvT3Qvr3DlM4r/dYCwIlel+FkxXWny1Vt5Pu19nUDhTH13WGD+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4tNQ8cE;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015C606A33C
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 20:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0015C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4tNQ8cE
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so2598087c88.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793564274; x=1794169074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IslZwScJ+AfRGcBpiL9dKDI16HL4dxngXHAAdwckctw=;
        b=R4tNQ8cEhQbr/emYtQZ0+NbX4/cQaAn9PE0g1wLTTGd5zzE2oRbS0kec22MyV1SMjj
         80l0uaEbuszJcGTIlhyz6w7124aI5BsFSzV1oOWdr3myFQOQUXDJ97rCpPr82DHt73zL
         Jw6Vgac3Zl0J1ypUSXdc/ipznr3rC8Pkwy6nHRs9x8EXcT8ufhJBeNDmate0JFJ4JzEn
         mpKyFrN2Lpl9AtPnfWhj9hXxX0ChkH+P8EQ0Kz+QmbaHocHhiKkGluFbAF8vvIcJWCTr
         EXf3Ac5Uv6ehR+k3rsXW950g1I9qfhf1HN3sX9/c+0l/qXH3T6piG734xGaqCHo51x1c
         xAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564274; x=1794169074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IslZwScJ+AfRGcBpiL9dKDI16HL4dxngXHAAdwckctw=;
        b=BToKSMg9N9metI3UJP2cmRlvzyV+vom9pXOQufPKG+dDJMTUUgmBpU73V/YfHtWqPy
         JRVBjgrZmCOIW9yXa7geuOn6dM5Fs+WYPYCc1UTk0yLHaH5O/+9xIKSkTyre7wg1AM1l
         AR2mEtHYhehYM/4wuhpDd7BGaxPRXLVIXZhLAZh+/0YbVMn8JQovO4FsOztpcu64jG9Y
         zZxI2sFiG4IY+mldnew7rEmP9CXIuRw1zHWO8F48F6e7XpmTzuvR9w2TIYarMWZnjffa
         cY46PVukkYDv1vrksbfg1Jgm7mFlF7ke/NvK8uOUhD0z4fEqer7b/i7WhjRkgz5A4utu
         ZAhA==
X-Forwarded-Encrypted: i=1; AKwUvBwDGQOyPUqygJ2eDNLV91UoCy5pdU2PblBEZO5x1YgiAuDparK3cSHQnqGsdHNKCCnghe5tn4hBmNPO4+th@vger.kernel.org
X-Gm-Message-State: AFq9FYJuuWDdfZY9PwlG8pjUVpg4581hXL2NG79Y+2sSMeOtV+bMjojq
	d17MTb3EuFEScujbgbjrEGae4sQFSv3E568lc5vXpwRlVAf9LduBEF9r
X-Gm-Gg: AYBFou0d0r3wbNNtHgZ7V8sI9KSnuYHfuufEHapa5Q+xnTCy1VjQX71EKvifflICjph
	NMIQChvb7atqR0JBQMVvg77ni0/i0RLs/2XEFHNr1D8J6hhTGVIxUIi8QOi/Q5P8obrDl2xf2q+
	r34joGzyiiEk1QFD9IpjcRxBp2An/P8oSwKKUNtC6/iHQInrRgia4vcV10mXRFFSux++eKQomu4
	x8FmpHBYLuHwciy+yv9ADThaIdtieZLMlWrW6dFtNpnC0n1JAbeasAiKhCoEN2SUaRQ2n1VRzBn
	09mjEQrP1wSXQgV7xvrrZiH/qYeBaNqYXEC+p4rcUvN7M5jE9mC0gkOI6Jgj+uV3jXl6sCQnT2P
	jHWcnuRHgco7UcnARuDJoG9ro9G+6006LQZCarjjcnpk3mL1gnNRhpJsZKhIpCAYliOGugaImM2
	oD+Yg0YbtjVxQehZuogRXHI5x+6ObsRsVv3AgEKWBEVV/tAA+f88efP8yJDrMemnHcFo84SbwhH
	yeHdH5vOvGsehdOasNOizV9kgHTGJEO7wXcy876GL2NxEna3LMyYAE8BaoKjypQF3EDzRoTI/w4
	hlf+5cetv17O0gq4RRawH28hp3Of7hTFL5VUquiuqs8Nddfoqla4oktYONgud2eyhz8=
X-Received: by 2002:a05:701b:424b:20b0:199:7dff:f9cc with SMTP id a92af1059eb24-1ac5ceefcafmr12613027c88.42.1793564273864;
        Sun, 01 Nov 2026 12:17:53 -0800 (PST)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm26752101eec.10.2026.11.01.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:17:53 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pranith Kumar <bobby.prani@gmail.com>
Subject: [RESEND PATCH 2/2] eventpoll: separate nested-check objects by cache line
Date: Sun,  1 Nov 2026 12:17:31 -0800
Message-ID: <2c0964029b9cd01bf214cd9a521ccaac6afdacb9.1792432666.git.bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792432666.git.bobby.prani@gmail.com>
References: <cover.1792432666.git.bobby.prani@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generation stamp, topology rwsem, and global mutex occupy one
64-byte line in the ARM64 build. Readers of the stamp can therefore
share a line with frequent rwsem updates from independent workers.

Align the stamp and rwsem independently on SMP builds. This leaves
the mutex on a separate line as well. The rwsem reader count remains
a shared object; this change only removes mixed-object sharing.

On the local four-core workload, nested throughput rose
from 5,325,959 to 5,487,081 pairs/s (+3.03%) over the parallel-add
change.

Signed-off-by: Pranith Kumar<bobby.prani@gmail.com>
---
 fs/eventpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 635db25e7e93..1d616a3b7b5b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -422,7 +422,7 @@ static long max_user_watches __read_mostly;
 static DEFINE_MUTEX(epnested_mutex);
 /* Local experiment: hash collisions only reduce concurrency. */
 #define EP_FILE_LOCK_BITS 8
-static DECLARE_RWSEM(epnested_rwsem);
+static __cacheline_aligned_in_smp DECLARE_RWSEM(epnested_rwsem);
 static struct mutex ep_file_mutexes[1 << EP_FILE_LOCK_BITS];
 
 static struct mutex *ep_file_mutex(struct file *file)
@@ -430,7 +430,7 @@ static struct mutex *ep_file_mutex(struct file *file)
 	return &ep_file_mutexes[hash_ptr(file, EP_FILE_LOCK_BITS)];
 }
 
-static u64 loop_check_gen = 0;
+static u64 loop_check_gen __cacheline_aligned_in_smp;
 
 #define PATH_ARR_SIZE 5
 
-- 
2.47.3

