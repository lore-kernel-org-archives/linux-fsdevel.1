Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520686;
	b=VbUfmKh9bj7ezmagYwT7kDWhlfoPRHT6gYrgz25Sppnr3dkfqwwe832Y7YCBt8tj3TzI
	 MAOSGZ7Tktf4ddrzUiNV+eCQ8dBq7ak+s7r+tzqfZ7j2xLS7dtN0jOFPmxjDuaTw6tBeh
	 rHnw4n3xi3BVXctm86ZAvr4rNgBx96AtyiX+eJp1GpCfzRj62Rw+cg/fF+w8ezwNCEnFI
	 qjPDnC6qs/1Ee1n/rgtTmmuPV2m2z9X/KkeYcoE5fsPWtXhI7WrfSU99LN6G9V85cSnaJ
	 nU7/gggtqLUlM9qF11aPiTD8QVVPBlsb6BUy0n9WOpwe8wKhmBIq48gi23KqkOfrqxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
	b=on3YNz8Ugwfj6owIZF8xBK5vb/IiFx6sXIGb+WUeUkulPEL1tsBN76Ey8F16ImbQlPug
	 Q09EHbHzRIJYQASZMAUU5SHsu6NczjpBR8JX8xh15b4OH/JLNT2y7q+B3WwgYcuP53KhO
	 nLrS0xzDUTHSa4ZHIi0SmSowRbBp5c1fApFmaUfhXtWs1ezoJpVXrqqQZdJYIg+XzCV8t
	 fj1QRF6y+b4zi3yPga5PDLC0D1vL/9s263fZeIIZS3Ba+Dyc1pGcIa5jF8ZW4wzoGv+/w
	 gy5Dj0mOCKQgKTFxmq3n8VMTPL03I/NDTc8QaMy3zzdQV1I+hANzEAjvmqRPnP1ls1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F06606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 18:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F06606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso1234929a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520685; x=1793125485; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=BGtd62OeWPju/vsAngLNxXqcgxNfyL6+oltPcIxN2sjko2c+R/Pjdl+lU60njYYNTn
         /RvenEldENHkj5P3LwKPrWJxxODoN2CF7ex4BbnlUAKayCIOifgNe6CIjrtTlVGoYw9p
         xRpxpKK1ZBGaHWqi1bhPWGtcrGYihNoL31M3s8YoHE65ncWM98dsuaiv9VPOVbYsuBSy
         78VFlK2gPYjHtVUozr899M0VDZXb/2WX8yMzec9LPoshvwVyKDLHbs+5gSovm7Yl0K8B
         p6QvYWvfPiynA3JnJpAtcz+NRJTTDSvuRFvkCQoQ8I5mKGPa8XLBgeJjx4pk+vWA4Zm/
         YMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520685; x=1793125485;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=LtFbJs/47lElr16JIgLtFlX3e96POk23R+nAK/EyexNNZfRO98ltSU0Y1EYEmQUKnA
         CowoglzqDKygKy/TIyxbBBdQ3wiOLu8CVhE8Shi1oAGEHtrPRZnKsH13m1G9wzHXhM9o
         roVDasKjYDsbIfg8AbKCY9zJ4ECbfLy2SXzsHqpI+JaxfHeZFC3S7W+PApV1WHmpzwGy
         zdnlXlH9K8y+q/h/t6sSN6ziTKMJ+WRy8hCcp5xhKJjZolfa55TeZqdAih/Gubl52EGR
         WjL5wvcRR59J1ZRGOqAz/y/NWnXtQk47EYTWiii2YXw8wQqxIGHnHUSCpI2tq/ETg664
         yfRA==
X-Forwarded-Encrypted: i=1; AKwUvByiLE6dnwvLXNS5F0NDan9lPH4YevT2KK4RWWQMOylLe/7Rr1vzkzcXI2PHNku97RN3hCGJYYcyNQ+hparo@vger.kernel.org
X-Gm-Message-State: AFq9FYK2wr1gxBq/4rRymiE37Jr9R5nKX/dV5RzVQsjsoNppj/q9aSXr
	EAvp7/UGKBbBf7tQph/2wMUM6H9VUje0mN67e6EUPk+mK+1lqw7ML+uR
X-Gm-Gg: AYBFou3VooBRuvCRFYCIOhuDACu1blmfL7+pRqeKdjcJlezEqphWQTOLPhPPbD0vcr/
	is8howTegnkilOlyip6HgMvWEpNoS2bSipraLcPxJtQ/Z0kgGWKJgjKKRuz9And+jfVGHNKYqXb
	GU/mqivfL/R7mirDOO1DAp8xL5jMx9jyzodRV8oBZyDWA4IHCSbE/MSbTxTWs9kHDNaIyIvISy0
	l0bHO0S4TCJIssixu/XGOwrzfcdN3DpmoZW+SjmBJqd7YPu6/f3iSpnUid3SzuV0D8yIu54Exx4
	mPADuN6gvU/B9Px/jvNEwVeNFa5f9JwH76G6ovvVLKCPsJjUuwrek3bp1A9n+bbNF0W05nmkSAo
	AmGPU+57D4ztkNOAZVS5kBN8FCjIcGigBbe0EKqs0c0OGJ6Juk29RrJCKpQR4Z81xn0mKlCj8sb
	pFyj0hn3MMH1M4HxjgVYlrpYK6pqYDQUxJMcuXX+Zu9fU1o9LwUuXklS/b3GpFoOCT/zCJwJRf1
	TH2aMXr9tUsMnOb2YJf3oVNIurCW5OhlHxQDqWvGvXGtP/B62OYUdzNCpGydwxVfMF1NJ8EEFTk
	PgMF
X-Received: by 2002:a17:90b:1d4d:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3acef5f0687mr8948009a91.64.1792520684886;
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad835fada1sm173708a91.1.2026.10.20.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 18:24:42 +0000
Message-Id: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Matt Bobrowski" <matt@bobrowski.net>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 <linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.

The crash is gone, but so is the path. file_release progs will get
-EINVAL for every file that a task still has open when it exits.

It also breaks what works today. The d_dname branch in d_path() returns
before it looks at current->fs, so at task exit a pipe or a socket
resolves to "pipe:[123]" now and to -EINVAL with this patch.

And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
that current->fs == NULL in do_exit() breaks d_path() called from ext4
open.

can we fix it in d_path() instead ?
With an empty root prepend_path() goes up to the global root, the same
way d_absolute_path() does. Then the check in bpf_path_d_path() is not
needed and the selftest can expect the path. A chrooted task gets the
path from the global root, but it doesn't have a root anymore.

Something like this (compile tested only):

diff --git a/fs/d_path.c b/fs/d_path.c
index c253090..ea49d33 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 char *d_path(const struct path *path, char *buf, int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
-	struct path root;
+	struct path root = {};

 	/*
 	 * We have various synthetic filesystems that never get mounted.  On
@@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
 		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);

 	rcu_read_lock();
-	get_fs_root_rcu(current->fs, &root);
+	/* Past exit_fs() there is no root to stop at, go up to the global one. */
+	if (current->fs)
+		get_fs_root_rcu(current->fs, &root);
 	if (unlikely(d_unlinked(path->dentry)))
 		prepend(&b, " (deleted)", 11);
 	else

pw-bot: cr
