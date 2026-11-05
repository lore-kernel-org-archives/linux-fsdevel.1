Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891875;
	b=4sl57UU00S1tyD7vo86Cy8ZS9vBdNyzxAhUa4Q9j5Ln7w2MtNxp72Cl2WcJavaGF8Mj4
	 gdTZ1bhn0l4uQ6uEnogAUvVib8B1grc06EnPjdNye29AatdVIm/LPe2IFpIks1/4iCRvA
	 fWrUz5YbsS7xcUs4EILVAu0pVGXhiUVuA3o4NABNv+TobPxGUMJZL7/inuBFdGR5HpPXm
	 95llgfUhemKNCFwh1kjlCViT+gjbCbKk5iFPOoVco8wS14EHC5hxKRrgiiAS4Zitg8usX
	 UuzAOgr2G1QVzY9VMLGKqt5OLzGqdmX5uGIo411ssFfBctBtGBBJRouZg2ox4CZyPUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SMC+qrNJfteCE2o/qV0U9H+g8BGqFXxMiCMNBQkq4Fw=;
	b=AG+q4XXpHETybAsHrKMEWuVeDvnAqwFyboSvaPHJ/zJseprKp380vq2W1lb/qT//aDFe
	 8oPiZyg1fqBi8fZ0eP3aJ//M4TRZlreJlqFk2B3Im6ZIGgfEB3FHvvUpoz5bLavwGMjjD
	 +P8UR4tURSR5VLx2nh/QoYKlyPeJ4/Jqrrc5ZSNto3OoWZWJes1g36m9xjimMwto53Gku
	 9h2PfB/gxacyPFtLTwUU/p75sf6E/N41IP46mcud7UAnC3pzGui2g2VHIpFpt6sD0E51v
	 xW3jA80hC0PwvuSUMpt4NUXgpv6rztwX+f5rGz27TT1a7z4ufcDYaKlKk7pkxBnhy7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=h77oMB2A;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF669606D804
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF669606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=h77oMB2A
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1270952137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891874; x=1794496674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMC+qrNJfteCE2o/qV0U9H+g8BGqFXxMiCMNBQkq4Fw=;
        b=h77oMB2A5XRyL7jxp+5PvELDe06BT6sutaaCGWAvrkxChsFzlwb0TFG6mRZZdPITPK
         +cOpsQOTGJdQODxOeVaj6RInp9Xj/Q+mXTUpkuO0Vaxkh/jookOT99XwP5JeZ6Pk++mv
         tZWJWCbjzRHInRrQcPsyLgRihNHkKPXg0dRo+edrDpuQe/nkWyo0QWa5ZDaZ+LNaXOzO
         68EYlsnR9G54V4Y696ktTvweJelWQ4pLwS/bC9IYTt+40Sp/A2x60Qyq+hyMi2TCn/Jf
         eFt1pWEKl6pOmfSluFMYzmeKxe04zArMJxZNnHTHRVAcJAE0nrAozI70s6KNNi/Thkr1
         M4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891874; x=1794496674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMC+qrNJfteCE2o/qV0U9H+g8BGqFXxMiCMNBQkq4Fw=;
        b=Rb8Nfvm5+jCNnbbgykY+gd71PViNDfguS0fW48Yo3FX/oD2UfrIYShFs8DTNgguLGu
         /tMFahhNegFU/OdLx4gwrJKhZC9jGgDRecHT4SBpTEzjTjSrdNfujmoV+Fgz2qo0dAh9
         zXVfNZgQgjrGrMdzvwdXy/6k9/STrUhu51zs8U4iOlIZZlrQNIwUo44xDw8+GGDo3rhN
         pr8v+YGqIyHu1zKMvH8fNgiNV1ayHitDfhJ+I4sqhkYVuPs3Z/14RHBchMqCjZICWh5a
         2Yza5wg3P9RJRDTWvbeSEs5Td+6XUqblMd83rMuBNrhBxNADUp4IqP8Z33vBcDkeD3DM
         wG9A==
X-Gm-Message-State: APuU4Z9YlE4nV2mBWpS3vJC3kpMrGy++YbbxEijP5VFB4mq+nt/V7VUj
	j2tbKf3YjDLaV6yYsnr0cNh014K4xPmSvtegRIMACyIJRyIC1Nkqy0Y4lUufzlC3ADY=
X-Gm-Gg: AYBFou0QNYo0j07xveH83luEFb6u3WxZP96c6Cv5oG7wbFIeJuvz5NvrysQzBvpJynU
	ctwVmKS6pipn9uixlDcXpT9Qibfla7WMUsbSCQwRanFeLQnEM79XSUWajWqQyH1m4LXxKbTQKHT
	w2L2JA8FkZA3dIixfFLn4eS1gDKwfs8BajqYzYPdl05q+Y2qppqgVOyeUwbZBLejKNFdTqOzfr+
	x9l4KvErbJM4op057rGH2RY+C8wvcA8EXBvQHeXub2AJD9GmCWM8I9x7Rgxd6lPMaWbtW3deskW
	Lp8Nrccf3ADPzrD92haWkIuWKODbRNhtdsdSnhrP+mBmqrpWZejLUzbrwLQzjQi8BpDgibdiic4
	lvvtiNBhr/V6i1hJjJrmhxaQ0kP2zqeOIZQbNRkXmbScFnxb9L6lSyICWB3ihFMl2Y31BRxh0Rs
	ZB3Gm8kDhuN5w/4IQ7UhRwoE4Z4a2RvnNZoSt1gnJTWs9gU04Pd3rsQaO0KTQkMX38qGzKPz71Z
	MDHO53dpR4NX86R86mQ9QJjhemVxy99NglfChSypkxIL2PqVO1J69HlwfLOxaGOBTM6aH4G9dcK
	M7Y72+mE3w/ujxIzzGAUUw8kxjw9f8NCvTQaos9bu+OOdr2t2SKZcHorJnrm9ZXBxw==
X-Received: by 2002:a05:6102:3f8b:b0:7bc:dd88:add with SMTP id ada2fe7eead31-7d0726716bemr8957996137.14.1793891873865;
        Thu, 05 Nov 2026 07:17:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fe8f991sm4364149137.9.2026.11.05.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:17:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:40 +0000
Subject: [PATCH RFC v3 48/90] fs: refuse a task of a cell a new mount
 namespace
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-48-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=1326;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=nOXPHVO0v3hT1W2sHrZgWd3DNxkisQUAUu39TRuJmkY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP9wmFv79GmH7EDKeFr9zp93V2hE/JATKfuBmIF+AlYfCq6/zq/mCDJAA5ZbBuYaoibPpl4dLA/
 r4dWY2nDD2wc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

OPEN_TREE_NAMESPACE and FSMOUNT_NAMESPACE create a mount namespace without
going through unshare(). A task of a cell could not enter such a
namespace, but it should not be able to create namespaces in the first
place. Refuse both flags for a task of a cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7298b589e10e..30167f8863bf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3353,6 +3353,9 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 	 * just care about being privileged over our current user namespace.
 	 * The new mount namespace will be owned by it.
 	 */
+	if ((flags & OPEN_TREE_NAMESPACE) && current_cell())
+		return ERR_PTR(-EPERM);
+
 	if ((flags & OPEN_TREE_NAMESPACE) &&
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
@@ -4622,6 +4625,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	if ((flags & ~(FSMOUNT_CLOEXEC | FSMOUNT_NAMESPACE)) != 0)
 		return -EINVAL;
 
+	if ((flags & FSMOUNT_NAMESPACE) && current_cell())
+		return -EPERM;
+
 	if ((flags & FSMOUNT_NAMESPACE) &&
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;

-- 
2.55.0

