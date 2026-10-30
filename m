Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371576;
	b=CdMVQNdefRwGbW9SxREsqYOhCAuhPR7xDEIQxxCOmI+26h9kdwWoAKBfAcaUSeZCzIKl
	 mK5QYQouAaBXw/AsRAjsD2G+6fsOR6zfHcX3vYwG3t/LL+wuCN3aOjAJvVSYhKAVISt85
	 CWclEzUPeqTswPr3kA0QVH8h311er3q/PgQ1rDOJ6KY15zrn8GgM5i0yAltH3LBlbdszy
	 qLblQc/preSEfUSYEwlr40PrwsS49TXLP6xRK7SFoLvzop+FEQaYprC7NDlG/nr7EVmZ2
	 8W2icI4oIrxuKPkQgLv4p9Xyv8fBSXkqNqBZTck2m8UzC07nBUJEcDGRaFF8cTvr9PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=RclavrmKYR8zYBwA6iFW+yoiLf2sni8q7Y+lTpJV7rY=;
	b=P6zkTrhLgfABrgOIfd+wkz11er1U37OMQUCKJMw5yAYWaw0Xkdq+mDYnPM8VImaLZSqe
	 nHMA3JvDQlLZFDNi9Wd2UR9DPkLFvIUJe4+ISSrptjqiQiT2miWxVpRjwSaxiMoeQrZY6
	 SbXU9ALOL+EFkZFN3LahNWfvyR5gAHZSKD+rKKGfnszOkW/IYArWB/tneqo84V6vSd8s2
	 Ikvf6zzpLPu57veh2g1BDxktpGHz1gvrYJV4DrDO6iBPbro+VVc400zxoIby45uemHdCS
	 zfhrJWb0v+Rv2bNT0C7VSmocfDXScVRhHmVPCTG4wFhdZnx7OPfCTWDL96AbHvTcy2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YnCc3AzU;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8F606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA8F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YnCc3AzU
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93cc1ab5f6cso89438785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371575; x=1793976375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RclavrmKYR8zYBwA6iFW+yoiLf2sni8q7Y+lTpJV7rY=;
        b=YnCc3AzU932Uh0VKVJRYeB3UHTTT7A8qJU9P0LQiLGEpuhPsGjfYXEam5wCDMf184W
         h8WwilkqJjthmgBkDTOxubTATjFU8ISpe5xRe5gNEuHt8xqZCTadfkzGoJXJnND+L7Fe
         htDYCSqbXCGMpdzco5t+YwvHM/mTvxAGJzs3Sb6fRUIwNOtdBwS/C6VwOaw1ShDkgGvc
         0K6zXZz01j8Uc7mD3YlAldHDN+vh8dbng4XsrTbmUmnoS+LSvNPgjZ2cvOn7VR2oZuyj
         WP80I5LSUJVqnTKqj9efzZ9MMOa8YKOzRIf55W8fLXsxZwNvy7HuVVd1+3YQDqxTUW+U
         giGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371575; x=1793976375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RclavrmKYR8zYBwA6iFW+yoiLf2sni8q7Y+lTpJV7rY=;
        b=i4vc/zM7Jx5RmZEWGEvv6mdLlP/zObKaaQrz3UDYxTER/IZV+/V6IBMfkl6EFEduY9
         oo2kRZQyncuisTxFhGJvTDDy+enhj0inuTFpFr+M1M+hDmslpl4jP/rnNX4pKLZU7Ob8
         bipPHm18Up5NNk0HACcq/y+OgOKA+2ZDV6ydr6KSJenqnLTgpa2Z+S8lRTnvCKbvLtHb
         tAgHU3H/QGNiZ/hOTM4tveZ2fHUj6Wxp5moBAhZulh4AN5BGu0AkJL61JXJPRHonbUO4
         lwA1f7lqLsnJfQAIGLQZ43fDKpn15Acc08OhbxFGCP9X0FcXMmVGfpo9mgkS36tMbTrp
         N6Jw==
X-Forwarded-Encrypted: i=1; AKwUvBytKnmTr+vgXFHnj+SXobG3nCPgeOJyMa3q6Tx+ZTrXTLqcG7dhos2z1E6NiTTKS5hVw30E1oqpUGrqYiMW@vger.kernel.org
X-Gm-Message-State: AFq9FYK5LhWTU0BYUsPxrOBfSK0nmKSTIQ7ca+9PUQr4kCDol8BihaoS
	365IxqSV6s/V1SeZOJaRiiaWeEDBf6iG0DIcUfotx49HhBYYyws7YVHqqED4JZbDgvo=
X-Gm-Gg: AYBFou2pBanSMhhysQB1Cn/kAnT5QdiuX/iWV72eu5gue0NcUPIFJFvxfQuFox+Bg54
	oy2DfFTTHHXQ98cq8SeJjk6zaN55pO26sRqCKHWIw6+SULI7kFS5COVqAoixCyKuLYQrg2TBKqw
	5Xm4Q9BUc4mBo+Xdm+mSGRSKrtobp8oGrz8TiJrj3SVdAI8iBtGZ3DzRz6dm5fjnK1PET1s9C5f
	V5TqlaUOKZBJTO8zYIjAPtxWgxtrS1diK8vYntck0ql7MWLqTSyGFzX/Xqddtci0kdmKmcrRSHA
	yu0b9n8LBbcQYU0uetCCm5XqK0zO2Sgh0hLhGl8/kUEqle8AHX6f5eJ6KNZfi0f8d6WXX2kjsgp
	/DS2JAFJLBm4Yy8U7dHLO7Ho+fo8Ic5FIMjBbj54JEepuLXbq/6OlOdbe9uXKFyMvd7b2D+3/G3
	7FYQmj1t2gb3mHbeUh7OXDHty27GwWU/OnmMkZgsnh2q+LIKXG2M1ne9XqiAeBsTIS8ex3HGxoF
	gcKNib4SQN6r2+ko2rzN6Mwg71ZrWrl94vAta6ZND4HTLPviUlquO9y6YcK0JhgtADpj97pEEnO
	ByqDYDK9xtv/IcMYG/+MEt9Ln+RL9xSDoleBwrlHQl7oSQ==
X-Received: by 2002:a05:620a:2989:b0:939:de48:e41f with SMTP id af79cd13be357-9442167723amr446697085a.31.1793371574905;
        Fri, 30 Oct 2026 07:46:14 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm158644085a.1.2026.10.30.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:46:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 14:46:04 +0000
Subject: [PATCH 1/2] binfmt_elf: fail the exec if the image can't be
 trimmed
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
Message-Id: <20261030-b4-binfmt-elf-trim-v1-1-dbd8683bccf9@toxicpanda.com>
References: <20261030-b4-binfmt-elf-trim-v1-0-dbd8683bccf9@toxicpanda.com>
In-Reply-To: <20261030-b4-binfmt-elf-trim-v1-0-dbd8683bccf9@toxicpanda.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371570; l=1902;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=mcWigSZ31aOPfjIvV2ZnPXU0SXI61cAyYzcWE50Squo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBpJcKYFs7IlTwoxGS5PBOmkhtM0PT5KngLR7zx8sX79DnQwktQo+kY6Uvnt8SOiw21Q2Qpyf6p
 sF8oWWcAvQwM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An ELF image can be started with the holes between its segments filled by
file contents, mapped with the protection of its first segment.

elf_map() maps the first segment with the size of the whole image, to find
room for all of it, and then unmaps all but the segment itself. That unmap
splits the VMA, which can fail for lack of memory, and its result is
dropped. This was reproduced with fault injection, by failing each
allocation of an execve() of a static PIE with 2 MiB aligned segments in
turn.

Fix by returning the error of vm_munmap() from elf_map(). All callers are
past the point of no return, so the task is killed and its mm goes away as
a whole. A failed trim of the alignment probe for a static PIE was harmless
so far and fails the exec now as well, which is not worth a special case.

vm_munmap() returns -EINVAL for a length of 0, which went unnoticed so far.
Skip the call if the segment ends in the same page as the image.

Fixes: cc503c1b43e0 ("x86: PIE executable randomization")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/binfmt_elf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bf7f8f47548d..bf0d4df16ae1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -391,8 +391,13 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	if (total_size) {
 		total_size = ELF_PAGEALIGN(total_size);
 		map_addr = vm_mmap(filep, addr, total_size, prot, type, off);
-		if (!BAD_ADDR(map_addr))
-			vm_munmap(map_addr+size, total_size-size);
+		if (!BAD_ADDR(map_addr) && total_size > size) {
+			int err = vm_munmap(map_addr + size, total_size - size);
+
+			/* Don't run an image that has its holes filled. */
+			if (err)
+				map_addr = err;
+		}
 	} else
 		map_addr = vm_mmap(filep, addr, size, prot, type, off);
 

-- 
2.55.0

