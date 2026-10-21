Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544222;
	b=pagTbwQUx3LYhOtkPgz/HK7XQxpobksokrOBU1yYOJtTOetTHd0hq/SudB7f1x0aXJNy
	 cDAeaqYw+Dr/h7ifTcRZZ9yXMqt812MBbtDkygOyZoG/s5d3LsxLr61M4S2cdlZcAM+Jn
	 fChAWD+9Ak3fD2eHr43uGfBkIdfcd9czpJBnskjA8wGLaxPPh22A4lc5hXzmqoi6n3ck/
	 +l3GCghJldvQidL1MYSOAHRI52cPXURJo5QdJZZ6U2QBviGLKFAl9sCfojKU4RfpkNi2Q
	 TfoZJ3j2Exgd+VwoFKhCER94Z+mRXr0XOeNt03uft+qFhe+3ad0JdCasDJz0RXENX+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OsC+tMi3xsAaq7lYAEKUZ7THAxkpwlxVniOQwZXZmIQ=;
	b=OO6aBKYEKTJmZzOV6afKwCvZZakLEy/LAinZkEHWVaaqu5TmRPJIAJtrAGxdZCh/ljW6
	 SQmUdk8yjHFPNUH6kXWQEL8ma3aTsbtXNERAYO2fYVHOcDW/4IAvBlxXOHonYFrpps/Et
	 WkcdD2m8wjvKW4GS5sUgVWYAs8WLm9dkotOkR7enWY9Eonu5//O3bVFVV5YsCpQUV25xL
	 KIKa8Oq9s2FGriszYcv5zvSQCzaOqZ3uf/qWEqGcmJl5Bg0Kd0EJSZEZp1Zz71vi0qxVk
	 I8xDBeN+2pxMTDo3P3K8CfqPoYBYxo6LlkqckU2Cduz0GOcYrvAI/3OZizyLzAgWBcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qw3nTdHB;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB9606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFB9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qw3nTdHB
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-535179e995bso2481391cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544221; x=1793149021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsC+tMi3xsAaq7lYAEKUZ7THAxkpwlxVniOQwZXZmIQ=;
        b=qw3nTdHBFeejS7BoFVnPvWUIDGyBSdH7DgGRPZAXLm15a2e1qsCgZBVSo2FMxCOkHC
         ziTHWah0wRUcOBmi3GUgyfhztGFysS3GttEKfak90/wjsZiFuxrCYD15rDPqwXVvv3RC
         6ltS46eP/cCt1OomnCe2u5uW9MIPdfpdQ/WVeEVMhDuyoO78jlQXxc3HNZciYDzOuyu7
         PEWuGPK8b44dUf29TeojycLiELf3XuJe5CH908JdqR06bd7mkEUnzWVxAygeEZ9KiNd3
         gVpCWpgiD2ymxJOu2crvWju1jZDhiV1ttUtJ6qE5Rg13X/SrqIGa3xF+t8BmfjRhfpsm
         9Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544221; x=1793149021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OsC+tMi3xsAaq7lYAEKUZ7THAxkpwlxVniOQwZXZmIQ=;
        b=W3HPWeZ7JMgYpLUjOwegfeXdc3G6Pp2871974SuRZEGwLdjQe5oPvCYFZwvfBSkrVn
         uwL8JvVvmWcVhMCCFzV/Gba5vYsgJHzC4agWe8jfY9fWi3Muc8VOcTmA5+VItWY0dk63
         alsFS7Ine5PqTduJt1U83AXdldLeWM0X2ZIh9UduuoZ9ba7Wj7vSeZ9gHOG4aXfAtRQU
         F+8P9TTCBRnO+aifpS3k8zX4rIPYo/Y/b53lOqLvEdlAIsk2BeE3rNs6I+tq53qTykGY
         bmzpxifS77fB+lKY0rNwQZlex+StoXmis4R87PkhKVWeX0TDTtzpw4N3T+7YTbQ+6QRJ
         2yvA==
X-Gm-Message-State: AFq9FYJG9u+9Lsm5veKsy6yPrfItQ1e5+XyOlqI01hyr78bQgaKVLewM
	s8VXNe7pAmjJgccFwS4geJ5nzxTus2oz+kZnnfGjBUsh9TOogyzNfzJQ3xUaG02jen0=
X-Gm-Gg: AYBFou311hymgioxnwjxi9ovfZHguQny11N049Z88Dkkrg+Qwo+cq9EYwkuTSuc3SQE
	Kt6KUZOkDD1NrBAqRQzEOk7835blwN5ykQRaZj6dXgoWweiqSrjBaTz7hYRIrupYKkIIR6QDEeK
	+ikF/oI/Lu9fxNFPr2SN29+BYCjmuQiqahBlK7X07MX/kzljdMvNUZiHs+e1cy7VSobF9vzHAQT
	nVHCLrRJbOrwt/FBuRsk79xNXxYVOUjuHtLIRlfc8ZSoX66gjvR7HaQYk+bUC+qqqeL7zYnqyMy
	OR8Q+JPJRyE0Ypl7FLi/j6PF0cuWCr67BYjs7tOSY9lrGk2JuFDFhH/AMl9DZtp0HuOl/poz5hq
	l5yRCSLZgZO76YqEY3IKI4P8MHJMBCS/lD3kdbKCeu2krehIyGEftIxEXf6HWK4UuMIgWTjhS9P
	FYGKFs0I8ULnvb+c2RoMkCyakm+FCKrZ7Z+zvG5sYnZTJOuSzuPvX7WQ/U6w+FfPCxRc0rUP/8v
	bCfvcRHtRGcaQYjgqGqa8JywqPEhM6cxw57KkS4hrklqEGvrANd4gTp9hnxZYBG4foW2fMz
X-Received: by 2002:a05:622a:353:b0:536:6d88:6018 with SMTP id d75a77b69052e-5369b8965a1mr8640641cf.51.1792544220916;
        Tue, 20 Oct 2026 17:57:00 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698ae608dsm8427021cf.5.2026.10.20.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:57:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 00:56:37 +0000
Subject: [PATCH 3/5] fs: make the block device callbacks wait for
 superblocks being shut down
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
Message-Id: <20261021-b4-super-lock-dying-v1-3-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544204; l=3377;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=D39p3y1yIDoZ+ep4D8MwYRO247+OyVwansyv+LMEiwg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDMiVjBndza+NxFXUuqT/hKXTGVF2xShNLpEqJnEeo3+3kEs52EyUv9fbeG93PgknNPwH+bF4TG
 XlvChBaqweAI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Three of the callbacks the block layer has into the filesystem using a
device rely on super_lock() sleeping on s_umount until an unmount is done,
in the same unspoken way as sync(2) and freezing for suspend:

 - fs_bdev_sync() is there to get the filesystem onto the device.  While it
   is being unmounted, the unmount is what does that.

 - fs_bdev_freeze() promises that nothing writes to the device once it has
   returned.  An unmount writes to it until ->put_super() is done.

 - fs_bdev_mark_dead() without @surprise is an orderly removal, which syncs
   the filesystem before the device goes away.  Going ahead while an
   unmount is still writing would lose what it hasn't written yet.

Have them wait for SB_DYING when the superblock turns out to be going
away, ahead of super_lock() not sleeping on such a superblock any more.
With @surprise the device is gone already and there is nothing to wait
for.

Only fs_bdev_sync() can be killed while it waits.  Its one caller is
BLKFLSBUF, and all that does afterwards is invalidate_bdev(), which leaves
dirty pages and pages under writeback alone.

The other two use super_wait_shutdown() and can't be killed, as they can't
be today.  Killing the task doesn't call off the removal of the
device, it would only make it overtake the unmount.  fs_bdev_freeze() could
return an error, but by then it may have frozen other superblocks on the
device, which its caller doesn't thaw on failure.

For now SB_DYING is always set by the time super_lock() fails, so nothing
changes yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 76101307da01..9baaaa3256b2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1572,8 +1572,12 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
 		struct super_block *sb = sb_dev->sd_sb;
 
-		if (!super_lock_shared(sb))
+		if (!super_lock_shared(sb)) {
+			/* don't take the device away from under an unmount */
+			if (!surprise)
+				super_wait_shutdown(sb);
 			continue;
+		}
 		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
 			if (!sb->s_op->remove_bdev ||
 			    sb->s_op->remove_bdev(sb, bdev)) {
@@ -1599,8 +1603,13 @@ static void fs_bdev_sync(struct block_device *bdev)
 	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
 		struct super_block *sb = sb_dev->sd_sb;
 
-		if (!super_lock_shared(sb))
+		if (!super_lock_shared(sb)) {
+			if (super_wait_shutdown_killable(sb)) {
+				super_dev_put(sb_dev);
+				return;
+			}
 			continue;
+		}
 		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
 			sync_filesystem(sb);
 		super_unlock_shared(sb);
@@ -1631,8 +1640,11 @@ static int fs_bdev_freeze(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
-		if (!get_active_super(sb_dev->sd_sb))
+		if (!get_active_super(sb_dev->sd_sb)) {
+			/* an unmount writes to the device until it is done */
+			super_wait_shutdown(sb_dev->sd_sb);
 			continue;
+		}
 		err = fs_super_freeze(sb_dev->sd_sb);
 		if (err && !error)
 			error = err;

-- 
2.55.0

