Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FB4718FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076846; cv=pass; b=bLtnOrc/ec5d7+IT4CoppxK0Io6q3+hA5r7TMNvhL600CG/dGegSDfhNDJQbZpRuDO9dFY/+TMhqlR2C2zGqiL0cfXiqNeXocv3IdVRtesdDgKrHsMdFIDgRNzFUPXkS+5B69wBrbvy9t0I0BwHFuuMR4Tah0mwm0TZ80E3+zBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076846; c=relaxed/simple;
	bh=MzvZV/XlleF9nFmoW3RU0rOHpGBzwcekn1hbt8ZFZE8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Oc7HiwNhPvxyzmpw90QUeR6rDRYtBCH2+hFO6fV2TXS/ftCTxvwY8kPXtRAYgPrq6FWmpuXZ79dluwxI24yy/Wps+eVoUoEkTPfguLF+dIm5sxr7hyC1NAcg1oyte6ecvdToUUXQGhMXAAc+LA0/tycTb+SVRMDxwGJtRNoFKNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=S94M893m; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="S94M893m"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8686f46e4adso176443b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 14:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076843; cv=none;
        d=google.com; s=arc-20260327;
        b=SvmzNFQtLWeGi8/J3oNOlfJwg0imJuFTmsr/g1gEy4E4tlwQcD4eeZuQBj0fBqrgCH
         Sv0WX584pVnTP2rDB/6X52FYU4d/raHl5/IRwVEQEmvF6trOssQ/K4pnmCAYJoqRfrJT
         l0HjnKrkE06ipFe8yONzR+bZ1ufsFBeHti8aPok5j2x3XNaNTaWmCJBrhcZSRmjpbDLd
         1K1VxS2I/J2Jd5rn/sZXvpvMWlKPKjeep5mCq86zJh4HrT3rcyi6ezCIFIXwsrq80IBo
         SeFLNJmTHxnsIQd+MHYropc26GucJrVYgi4w5jV/qisZrbfc/T41SqJFQzTHGyfGvJ7S
         TR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
        fh=zpw3s3U9xM8cK+E1A1BrPpHQZOZRb/zKyMt0uUzKkUg=;
        b=czB63W816OZ07mr6xqvLF37DcWj25AWlvqZ7R9QtWmyIl3aAKBNVCAFz29CE45KaxX
         RbUkxLSynPNGvhgkzzGuc5QyBgxwHecs3Wnf0fuhLC6RNUIB3nADNlWYQU070C3RUirp
         lR3io0DAqc0uMPkT8DUuf80mYA7RFwytEi+sdubFViL8VDXLVgiRph6qM8FfEQriRbNN
         C62SZpkEUXRDAqzZaRpRaP1rZThLh4rhdh4ymPn69rCq1jI16eI/x3adaiRYCkb5F/eJ
         icb/pwcmRusW103dk50v2RoC8a06Y8NxXkLF20SfBymFtMnIusygBhyrwBwyNvElht6X
         3mpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789076843; x=1789681643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
        b=S94M893mdJXi04bd8MM2f5zs1sddw6UOf1xB09iAmxQZswufex2KwMA96Pd1lo6wqx
         YzuSsIfOPc6X2Iq6ZaUQG58NkEmkz2t7ZaRDpyVAsa5v/sRGPj5FSYrvIpVLqIB21WO9
         4Sjff2mMVyEUGQjGjGiGSvVqYCRIT27cLPpB6tSmf2UvoPOHo1TNyn8YvqboKcIW3oiI
         DsFajtj0Aqvv+Uqacdwsv4r9LFoAQ/eSEZj1kfDHgX3p65hZKUWeSCRulcPzFaO9j06k
         mZT963/cNn5AvSaw7XSutyOcv4Pvjo0Uw9a5fT1FaENisRtDShAH4ooVWHcTq5Y+Tyen
         VgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076843; x=1789681643;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
        b=JnDN7Qrs5nnQ3HVCjdZd0QHNIpLuNiRLjz7OP2JyU4YH59oKuwrndGabrsKNJACWWg
         OyvB8ax4UXEhNXTO+pDkZO72mxvKyCI76pOmQF9/QKX0B9YW1S0SgwS2oWRy5tNJX6iW
         nnhDqmTDgBgiUmjOsN6ZGLkgyrBHbylJ8FKtvfqF+tQ2TGMgoSkW0uRNINU3x2gygiMR
         8aXZakKlmWknPH6JgHxAN6ZukVByjF9QRqWaQf/PE6DSwBpJ4W3QB4mmh9XbGVemR4+i
         L01N8QMAANie16EeYUT6vbcA4l3vjxwY9fb34ePcZsjyaxilIPg8gQZs25B2uPvJWkpu
         epyQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+ZtrG3Jh4ISeIfnbq8xjd8hym0pkQ7MgCQsJh+h45oCpS3KAWrgQ8JuZzdqpBMXBM6B1s9agao867s/52@vger.kernel.org
X-Gm-Message-State: AFuF++nUSkegm5+s5KCHrB/1CWASVhOP89UG0kA2ySFeH30CS29peRLu
	MJDfcxLf4wM3eHB3sPtK7ayOPA0nzb+m7Q945HIbwlM6swkqIF+jPXtSvuxioIARNipxhk3pxWu
	6pDgLoS3eQFvRw7X+oo2MW1aqDVV8IKdCn2vs+TaU
X-Gm-Gg: AYBFou1y3qlv1Pi4w0qqIHKzTdP99GVeCKmC4CKt+rzMDxVTadWiWSuuS/9mWIkGIm+
	EUEqn7UCZ1J4w8OebUtrsj5QqGpp34h0cmfNz70xVBpxrn19mGxaUenFi2sPLcr6BTkuodgTJyn
	wAvqXMnZBN4iwzu9UrTschEaRfHpD9X5vaw2knLVHygIxyHO+jZnKTeaATOToYFOLfB3XRSAM++
	JvpT5z+9nqHxjtooY4M/LXlfCMKpDOhGQpVyyvbv1GZBLa1ljyLo+agHPmW6TwJyfmscsbK+fev
	EfAxI5/pFzxQQW49v4W4BLyv1TlskXtX1BgZcvIuJ66JulSuN3OElUI2HPX3/qCLkE3pKg4qRSi
	dVCHTOExZk4YGYte8al/AIxjxYcI5H8i6arHk8Q+Dbec=
X-Received: by 2002:a05:6a00:c4c4:b0:869:427:9b0b with SMTP id
 d2e1a72fcca58-86b30e0c7f7mr1052490b3a.1.1789076842087; Thu, 10 Sep 2026
 14:47:22 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:47:21 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:47:21 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 21:47:21 +0000
X-Gm-Features: AcwNN1UuNgE93mQmrT5ODw4YWg2HNZ_hxuHKP9cOZHTw5nScsf2TNLiEOtPKodE
Message-ID: <CA+0ovChT6BRXp0kntaJ_Eiw-2-z=fpofsvyALiwdORe3zG_YWA@mail.gmail.com>
Subject: [PATCH] ocfs2: don't let the root inode outlive a failed mount
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: falemi@asu.edu, ocfs2-devel@lists.linux.dev, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ocfs2_init_global_system_inodes() installs osb->root_inode before the
second ocfs2_iget() runs, and when that iget fails ocfs2_initialize_super()
jumps to out_dlm_out, which sits below out_system_inodes, so
ocfs2_release_system_inodes() never runs and the kfree(osb) that follows
makes the stranded root inode reference unreachable.  ocfs2_fill_super()
strands the same inode a second way: nothing drops the reference igrab()
takes on osb->root_inode when an out_dismount path ahead of d_make_root()
is taken, so the ocfs2_release_system_inodes() call inside
ocfs2_dismount_volume() cannot free it and the root inode stays hashed on a
superblock whose ocfs2_super has already been freed.  The reported KASAN
slab-use-after-free write hits an ocfs2_inode_cache object that
ocfs2_release_system_inodes() freed during teardown, so an ocfs2 inode
reference that survives that call is a lifetime error on those same objects
and not a bare leak.  Release the system inodes at that failing
ocfs2_iget() and drop the igrab() reference on out_dismount, clearing inode
right after d_make_root(), which consumes it on success and on failure
alike, so it cannot be dropped twice.

Closes: https://lore.kernel.org/all/CA+0ovCjAKQMn7iF8BJR-3+G9_HBRnRFtJxjr-9P9GuKSxFj+3Q@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -450,6 +450,7 @@ static int ocfs2_init_global_system_inodes(struct
ocfs2_super *osb)
 	if (IS_ERR(new)) {
 		status = PTR_ERR(new);
 		mlog_errno(status);
+		ocfs2_release_system_inodes(osb);
 		goto bail;
 	}
 	osb->sys_root_inode = new;
@@ -1110,6 +1111,8 @@ static int ocfs2_fill_super(struct super_block
*sb, struct fs_context *fc)
 	}

 	root = d_make_root(inode);
+	/* d_make_root() consumed our reference, on success and on failure. */
+	inode = NULL;
 	if (!root) {
 		status = -ENOMEM;
 		goto out_dismount;
@@ -1163,6 +1166,7 @@ out_dismount:
 	atomic_set(&osb->vol_state, VOLUME_DISABLED);
 	wake_up(&osb->osb_mount_event);
 	ocfs2_free_replay_slots(osb);
+	iput(inode);
 	ocfs2_dismount_volume(sb, 1);
 	goto out;
