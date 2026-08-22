Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDF3B28D
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787373607; cv=none; b=ulKQ7v5Iqp1OIlF5lZQu7QDqVOUPedB3XZbw0THo/bY1MljpzTFX4IXbQnP62mXZ/ig6IztK+rwr0Ot5gQb6Q7aekoFvOaaZ17y1//ciyAnSCQLARwbcM3tmaUIwnwpEojOreaVDVkDj7DuAWlh7cSMrGtzluv7KMNj6fSkHgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787373607; c=relaxed/simple;
	bh=wexsQEqVH7+8DVlgsO5Cb3iEyyse0TcYw/ObWBh2eMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5034HZmP5PkLURto86rc/LnTW+ULWaq/61y9GPo76nqG2DtsnlaJDmqEACpeOFsTNnOacLxA7ZLCjXwcfUlgHanhTleey9U6ZF+eEL5WRV5O5HNUoPq/ztPR6d7+kJwAlFl7glt00bS4Q1WsBTe5RclEpeNcsjkERnndnT8Kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp4FYBJn; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp4FYBJn"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bf9548df4so1673493fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 21:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787373605; x=1787978405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ic6dzn00MSHabGZEeRi3xb/4yNpvOMTeHQtEmbSApa0=;
        b=Vp4FYBJnP/zU50fU6w4WV5lbaA+a8Fe9RJ2EbIePnEp8lo6owneWJ9stmL/Tf6vK8U
         J+c3/uG0JoJh2tgE9fiHD41GJwLjoQ7u8nLKqkCMPk7kNK8XFKTopc96KnyXs+EF9FOS
         Du8rIQOKEwHxU3B/Xozal4lthTN5wXelmlUAnMQZCRbDTz0NDx83Y3hh5fOZz8twBLId
         lJBZxPW8BTDvxRd+KNqfGoQTJJAentL8AQN4QNUdpxffsOybqbTVKCYRjf4i2SY9jH4I
         cvLayfNVpeEoEB13ffHZ35/VUoSj2jk8VxHH/7ABrRdiCs3jyIJ0HRq3ZMReLZl8K23I
         V+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787373605; x=1787978405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic6dzn00MSHabGZEeRi3xb/4yNpvOMTeHQtEmbSApa0=;
        b=Y+9sMDe3OXbe+cSj+BG+oAr1h/1pqXMNeNFi/hhq9SRa4ezabtoVJhi/+hRnTTnMOi
         fXhMPkdcV9ja85HbvkkKCAG5DbfI1sq/H7wKes45tialVXE5mnkPxu1GnY8/aoxA0rZ9
         h+PCQrCXAtWzerwEhzFUrI/2V42kW9WpgI7Yq19L9GW5sk/a/1a6anbvBto2WIcj6CIe
         VPUBAc0FXmbrVO9l5rzn/wYgkQqruOty0NhSBlqotqjYsW5AQ4S1WimZkxm6CLkWVYG/
         eTErK9AYYFPRV4WHZOHE5gR3ZP+yWkP7qQY2r7thZyHwpCA+jqkF2TVjkdvRtM8KFpjw
         vq1w==
X-Forwarded-Encrypted: i=1; AHgh+RrAAynEQfYB952HJ6hxmK+7vGkwATWd7IxUBykjo2X2kSf/SrF/oXpXOqaZKMzqXlKYzQ3UO9MiBN+e69BS@vger.kernel.org
X-Gm-Message-State: AFuF++lch+PcPcEkJ+GXYi267FqvufCbSlPuIauC4RNr/0W9R+s6ibwP
	ulr0+ofo+SfXB4gifDL1/R89UA5OqNx4VTJxZOuLYweyzS01BwfcP9S+AUUVMJ4pnTI=
X-Gm-Gg: AR+sD10/yPVLzzB5vLKb64DQixGxkrI7FLhTm2RGd1YRsUiXMBRd7nCHKPWJjXuX33y
	VYEy9bYaYDixF+DMdYB0TEaiN5hu8VCZz+TNMR3oVul7zkdRo2ppxEUv1/k7JqSWu1FsD/PBXpl
	Xr4APibHpeH+jg3uC9PiCgrmCcRBYdJ1anD2PQzaTd/96K1xkjk2fwz5v3ZdcIR2UTJtE6RyMkk
	leyOnTcEiXROXoUkaxiM+KG7uDJ4iipvYHHty0ezoyAYF18Bqvw5pLjpn8B2E4orMLgsbboKrYN
	GdQzdjiI7QKj3HwYwSnANfI9aXpThRgtGXMendkWshIBCvuE9Y4UGlXhxyc28iRS9LrtzMfXSJa
	DuHwJlfZZVDSTl2gmaO0KXyj8AXeaLNfGJaWpFM5FcZROX2zLEY9EKwC8ow5mjrAyb8LsHKMhm1
	pD677l8oJR/sQUzJ8q7lVKjzsJI0hqrm9qr1GZQjL2jFLNt4/aPEE2QTveGlj/ME1UsyAi5Ca2q
	pSErmLnmubiExAJeywj7egDqQoVsvgOcW4xyQ5/FewMTCONnr/I
X-Received: by 2002:a17:903:354b:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d64af6f896mr209334315ad.5.1787366371914;
        Fri, 21 Aug 2026 19:39:31 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761d04sm965825ad.2.2026.08.21.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 19:39:31 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hanzhijian <hanzhijian1991@gmail.com>,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: [PATCH] fs: fix s_fs_info leak when setup_bdev_super() fails
Date: Sat, 22 Aug 2026 10:39:18 +0800
Message-ID: <20260822023918.2498361-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_tree_bdev_flags() hands fc->s_fs_info to the newly allocated
super block in sget_fc() and clears fc->s_fs_info.  If
setup_bdev_super() then fails (the block device cannot be opened, is
read-only, or is frozen), fill_super() is never called and sb->s_root
stays NULL.  The cleanup path calls deactivate_locked_super(), whose
generic_shutdown_super() skips the whole sb->s_root block -- including
the put_super() callback that would otherwise release s_fs_info --
leaking the allocation made by the filesystem's init_fs_context().

Hand s_fs_info back to the fs_context when setup_bdev_super() fails so
that put_fs_context() releases it through the filesystem's free()
callback.

Reported-by: syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
 fs/super.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 05e443173..8b978b67b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1883,8 +1883,19 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		}
 	} else {
 		error = setup_bdev_super(s, fc->sb_flags, fc);
-		if (!error)
-			error = fill_super(s, fc);
+		if (error) {
+			/*
+			 * fill_super() was not called, so nothing has taken
+			 * ownership of fc->s_fs_info.  Hand it back so that
+			 * put_fs_context() can release it, otherwise it
+			 * leaks.
+			 */
+			fc->s_fs_info = s->s_fs_info;
+			s->s_fs_info = NULL;
+			deactivate_locked_super(s);
+			return error;
+		}
+		error = fill_super(s, fc);
 		if (error) {
 			deactivate_locked_super(s);
 			return error;
-- 
2.43.0

