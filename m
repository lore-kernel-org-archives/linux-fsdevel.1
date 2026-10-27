Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135390;
	b=5crWGgLSugzi22v7WWhd36weCBaAhI4vb6MniIwfhs1NBnDBBYf1rKvBbYrrRAwuVnN1
	 Els+X6AjucsDTZxqjCtqUIHJwOJJ9j0VKSanIsB3H3jCVWxo9qEn072CeqGyLpiAoJSIl
	 AX13jBSl9TgWo4S8/O5tslsLGkjx88ZgHrii15xHU73J7Z2CzeAYFqR/JwPZdNd7JOvZ0
	 HRqmyXB9WJ7O17ykTUGofVfzhQEqaA0TFlgp3ACe1B5z/MNLfeiFbBQj0cuKO346lI+Wt
	 7aC5QkQIVIxU12cyfCEJB3kFzGuL0iooGrLOC6q0ld7ueDBnr6y5QKJlz42AY1nQZ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=JKFrLSjwDHREmSvEFmSCml+HwjIVnw6Jy3aXf6F/H+Y=;
	b=iDwCWC/MsELsezt42KtPUJ0mupBOBr5MDfPLFY11SNA4lqm0/WYsz264cQZhdADxg2im
	 kOZCSuC1d+2oNlUO0SnRov3btwN5OU4rdv2dy9Sa0GJJoUvJkOYAsHDykkiVAcEnd4rhA
	 AcpljbnDNaNc0Z0tfhnjXLNY8t8oq1Hd3uueSJDnNzeneSu7tVi0HK6rYfZfCL8frkHEs
	 KhdTXDHuV4kpA7RZJYW6aEM75is9bRqB0v+O+Fnvtfc27hKozU6Ri2VtVIKZDPVztN0nv
	 D8fSkA6cb7SQ3CSuO0VsJu9O9lsr9b98qcvNdOsNg3wFP9m9dzw8IIUxQFKTEbSGxpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n6hOQTUU;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3A606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E3A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n6hOQTUU
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b55859245so4818186d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793135388; x=1793740188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKFrLSjwDHREmSvEFmSCml+HwjIVnw6Jy3aXf6F/H+Y=;
        b=n6hOQTUUqngfoaAVe+wP7OipaQREpIZUTmr+9ABQ9A+RccYPbJ0xQON28EvRuyVBqt
         r9HM2iZE5cGg3PPNbG9WI93phORSXncFRdrjqv+ei/9HVJWZHrloHKm4dVwJcpKUsKIZ
         1pKz0CoBUEo0w1+Bv4ggVwqXdAraxzEKTXRBNPzZwya47RBli+DIhmUMFp4Ur5xfJGEB
         DVacZ4aD4hdYD/qdT08/V59jlYOFpWLjCJ5MJCxwT0+od31pmaugcsv9ZAAyt0DtpK6/
         FP7MKuzv8SSpxsigqar6AIaK6iqcvukWr6ltLO/guLJuuQgKnfFpDgSU6h1AfRjjYQvv
         B6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135388; x=1793740188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKFrLSjwDHREmSvEFmSCml+HwjIVnw6Jy3aXf6F/H+Y=;
        b=X7iaogO+xJbx+SDE5c8sbR970wQdcncvY1UVU5cu11i19wAkfKBHHfZYVanmkXqdNR
         x5ydg4JlHSSD0K5cxceF/2DCSfhD8OhoHHAtvFMTo8uYQFhvAF9ta6kIu6HErsbEFcdp
         Yxea8K9jlaygcu4YSxTVYs1luKhiDgpaQghAO0lH/4HzC0VSY5DgTpFsOHPu17yAKvtm
         TbJ1WRdqt8UOUbNZa+lTH4EU0RZ7l1gcykJFo1FTzWwqRH8Gm2FFVykngPen6LZda24j
         i1l+Egr+D64LfomtwliAxFGS2ZjKZwEtfrIg8ue4+O9V1mfqxNdlnOflen6aAnYPMb0K
         zx0g==
X-Forwarded-Encrypted: i=1; AKwUvBzaJf98yUPofynFy6w44FF+Li+XXVoJO+1BwEMsKvhWPTAkeNOWPYl4/oRRrl3dndWAzAGd7naDJlb1lzSW@vger.kernel.org
X-Gm-Message-State: AFq9FYI6L+6utur3ly2o8sunBBwwt9/eDF81iHaRjXZJjO0yRUDzXns6
	WEvwix01cfc8eQpuNl7gg6r7TMv7QsRYYSh5EjLx0kGRx2L5M2rcbwEjeaMt13Y7MvQ=
X-Gm-Gg: AYBFou2VddDnuttd//9qFEWgGGUhKh18lTgovQFf2IOpfG2KwgdudXEEZ7On9ESUDan
	uHrWTy6C/w4HJjY5JhdXlZ7CPNU9MRzWDuBCB70OClI1Z8o9obkr1Pd3jlhsM+6cZ7fJYQmGUNb
	cYtWxQxoqfoOEJXJ3r4xwb2r5WUgMtZ1Nm/53ECbhBtNTDkpeRhDuofcKn5URNVLJ2A7SjpUdrF
	s6EH4GX+v1kQXLny70LLbZrSyf8DDP304tv51Wh9+Bri7iMK+Z6A34vnehmtmjJzoxD9cs2qrRq
	g7oY9tf5abumGrZxMGZzLDJnU4LoDjQrlW1zgVMrvtiN+hS6ahZdT/RzSBoe6fM1rBZ3WvLEimP
	ggq/wROaOzxLOSl54daWWUpd+IxrzUKqdt+erxZkL2+Mg2Q8+0NxNOADxN5tdvyAiAq6ikry1VE
	0f2x2WLRejylU7fDzPvqplWxqFidPVAFH8GZhu/NaDkfG7p0H+7nB6MpPEBOziQWvtgQHEiyFCK
	6/VQhi47rAoAHPSXqk7afaQ4RAhK6B0GIiVO2Hup321C+5gU8AURj8FbKMMyU7Gjg2uqQUY
X-Received: by 2002:a05:6214:8611:b0:91c:772d:fd7d with SMTP id 6a1803df08f44-91c7cf8f9b1mr5253166d6.26.1793135388396;
        Tue, 27 Oct 2026 14:09:48 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c8c2b3sm113364796d6.31.2026.10.27.14.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:09:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 21:09:28 +0000
Subject: [PATCH 02/10] ext4: set SB_I_OVL_USE_SYNC_FS if there is a journal
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
Message-Id: <20261027-b4-ovl-containerized-sync-v1-2-802e512379a6@toxicpanda.com>
References: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
In-Reply-To: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
 David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793135381; l=855;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aO8AZhSXBs2aP15NSjU103SL3h8/eCNuFcd5jsKb2vQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLYucfR36lRP85t2sKZ2ZLaJ9rWkQsjCap0MbdXMa/mnYx1Aa41Uw40CeY2ykt+WukwlWz8EyZD
 bupKVdGj8SQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With a journal every change of metadata is part of a transaction, and
ext4_sync_fs() commits the running one.  ext4_write_inode() has nothing to
add to that, it only forces a commit as well.

Without a journal the flag stays clear.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3ace06b4f9e3..037e274dca8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5542,6 +5542,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		err = ext4_load_and_init_journal(sb, es, ctx);
 		if (err)
 			goto failed_mount3a;
+		sb->s_iflags |= SB_I_OVL_USE_SYNC_FS;
 		if (bdev_read_only(sb->s_bdev))
 		    needs_recovery = 0;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&

-- 
2.55.0

