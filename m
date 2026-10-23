Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787991;
	b=xnRDFLCqy4eGUTpWrbJ+DHKjjctuokoNDsxJCDgH5gbHGWn2WvVD9h3HPeKxp9uPn8vV
	 OzlqAHN4WLUHtdCv8BFxEOnVkd/g6qqlKFnOZX9YUC7Ppe+/biYo9SuVzqrz7/1UoZlRM
	 rLIj9a0O0tZnV6+YchtiTAJcUMHcTl0MQbZHdLaJlJRRr7+axl1km0LGVNd4vAD3Y7Pum
	 q3HCmCtQAB2HPwRAHi8z9peo/ZXuBv0qMF1Hxu1T+nHVWcgF2n8OJH6r4TSKNqUiPz0Jm
	 4n5IVD+VBmjTs41phB9c2KP3wdBKBPxVqN5MpturCQ39UURmOxFCVgD98xXzrrI/fAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zycCjxv2CNNe8n4xUJOwPUmsm9jviG0vLy1To8XxyFA=;
	b=InBIUTW11B+qUPIHk8eIVa7C4WKHQYJ7jLtTYRFa+lOZFkF+pjl1BJ156xFVyRKQvF7k
	 jWvw/+L+ULEDmzNh/OSR11+BTGUZ87bKtAHYR8Xf7PndnBrKGlsHc+XVG+mTXLwYzEPlW
	 NDSEWoKbqpOPC3eyD2N9CcqEzuHl/xarhC0Upgp0JXx2TXD4agJOC6Y1aQbiSH4wA/pLJ
	 +CoGrvT9Y5VG+KGc/iEk7PMFZ61DFOMyaYt9waCvCxI25he4NUGqwJudgIqbhgaElt9sy
	 GQ37GWc+3nkGBMpLlaliztb1Tuk/c8YFSpI3xHuEZhuFXT/0JIIY5YV6NqUndcXUaQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PShuzM08;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEB606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDEB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PShuzM08
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5367cc15121so15868071cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787990; x=1793392790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zycCjxv2CNNe8n4xUJOwPUmsm9jviG0vLy1To8XxyFA=;
        b=PShuzM08NYnBVugZG1M39R2Q15QDphd1AhmdDlf19o8G89Zn609vGKZLIdJfGDH8jv
         WMAQPLTcckEAqELcfY0gJx1pU+Ja5BuQEJOvm4eVYCYYUhFqg4yS3BzXQpJem/yo8vDO
         8BiUXjU+Ki6M3aLqmSx5to9VworxAvGi5bZn4d7JEh5+P2KPYw7MRQTpQX8mAmAS5kBW
         APA+cZqinip2Z1jhcAk/mQA++OiHETGY/AANfddNWL2DyqYknmm2YZwhPMTaBXOmFhb4
         ZEADr66dWjNkkCBJFXH50fKZmF2w88b7nymzFMIJw8VFDR74qC8X+e/KPxv9/7CM+tWX
         efBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787990; x=1793392790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zycCjxv2CNNe8n4xUJOwPUmsm9jviG0vLy1To8XxyFA=;
        b=M/j3RZ+ZRQGb9k/ZH0DqFy15tQOJN65ZH20g8Ae6EcMG0mQCsWQXWwH5eFrhyw5ecL
         40z0jbh7GyX//7N/TQtRarKq0mvANmXLIjUkPRto8jyGUVYznSuS74VOm/XHtIpOcTJj
         k9R1khZyMO6W0ezkA0IPfWhPHNGIGo4C59Kdaqs8uQXkrRNtMwtnCIe6Tb2fGkN3/7mS
         pgFQOsjU4zs2mmsgLzZNxNTpzX8Vl5v5S1CN6mipyXaMcYcFsFs8A+UnWKlDyWiTR/wu
         jJBzldvSLRIR/ZtzN5nxgD/DLzAqV5/V9JgDLf4zguxur0zBMJ6EY/iJSjNpE7Zhm+ue
         mdBg==
X-Gm-Message-State: AFq9FYKyMvCJFayvKpNsayyAbGtZ8mzVg8YUoPBtDQCIUGayjtOErq+t
	sqMI9CmWeqjRZ9azCciL+6reiiLeEcLVM9j/0/5KiXvQd7kf2zon5FGPIqMBSgX/Sus=
X-Gm-Gg: AYBFou0XT0ojCfCgSTynT2bgzrjpBHE6UjZjrKDRV0fJgorPP62JnLcOkfpMui0o4Lh
	MAak5bwOMiSrXuFga92wtxTYYAj06udx/NFXXlKkFFPzxgWnuJ51sGSuFrKNbzFOOVUHklO8eot
	wGzS2BVSPGui057siqvf9uaynvleIiakkE595fGIV9d8AlXJbzJ5EEO+1OF4mSbXmO/tHbcFaZR
	xYmsJurjCEiPJAYvVSpw6SD4ejyCL7Zx4JTpdmCwcr5WDzUtmFBAZhkQhxUf+UJtqUNviMgl0ZE
	anrr8CWoscdw2sOQv+Lce3gcKE8fIwe8mC0VBN8k/cjdx94YMGXcVf19FmLZG5xcGXM+xK/Y27s
	/2JmiMicprx/lxBuVAhjQRKMxy/tED+yote0+Qxm31ei4HnzSvt2Vhl6GuFo5OmcT5dnIKUcY/q
	S2c6FqmFsyl3vb8eEDNAmTlquHcyOWcqHEG2Xz2jCj0fRiNuIJKK/nUXQd9RXKaMzGjo3SUiaGs
	MKxzACth5oSX2689u6s0k5DhH+RSiqxr3G30FR4Ez9S523NzvdgqveBHjXaeSBzF9VTNMT9
X-Received: by 2002:a05:622a:5b0d:b0:536:575b:8dd6 with SMTP id d75a77b69052e-5383af13431mr1476831cf.0.1792787989623;
        Fri, 23 Oct 2026 13:39:49 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53838cf2dbfsm2894091cf.2.2026.10.23.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 20:39:33 +0000
Subject: [PATCH 4/5] fs: make FSCONFIG_CMD_RECONFIGURE killable on s_umount
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
Message-Id: <20261023-b4-s-umount-killable-v1-4-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=1034;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BP0NwMux0c2tHlAlY2QSjhRjlwIiohWP6FQ3yScjWTY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGj8XMlYRyVtG6OJBzEl9Z6MzuvDHDsPof0uauekz8fiGcM2plJfBNIIySdcM1GQIewFjqDM3uE
 ZImmBM9iJnAU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

fsconfig(2) with FSCONFIG_CMD_RECONFIGURE is the remount of the new mount
API, and like mount(2) with MS_REMOUNT it waits for s_umount in D state,
can't be killed, and keeps every later reader of the lock waiting behind
it.

Use down_write_killable().  A wait which is cut short is treated like any
other failure to reconfigure, the context ends up in FS_CONTEXT_FAILED.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fsopen.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 70024870fefa..c139cec2f1fe 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -267,9 +267,11 @@ static int vfs_cmd_reconfigure(struct fs_context *fc)
 		return -EPERM;
 	}
 
-	down_write(&sb->s_umount);
-	ret = reconfigure_super(fc);
-	up_write(&sb->s_umount);
+	ret = down_write_killable(&sb->s_umount);
+	if (!ret) {
+		ret = reconfigure_super(fc);
+		up_write(&sb->s_umount);
+	}
 	if (ret) {
 		fc->phase = FS_CONTEXT_FAILED;
 		return ret;

-- 
2.55.0

