Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082B388E4B
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512383; cv=none; b=OV82Kw9moeZdt2r0gEJjOMszx+GcQLe4XIyr/53LIyj/21HWcdAe6aGn2VrsCJqO6iMzqH+uF8A4FVvgGdAbMdYWhkoJy/U45Kmw27r0h6yi4FoNA+3UjtwsNSScWm+5tBni4xwJc/PMaaFeP6EiCaqRXKeK4pe2N5a/j7nBBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512383; c=relaxed/simple;
	bh=Owu2yQZ3ssiTZF54WlJcep8/1pFQFocuIQQmghBWd3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0QonFF3Q3z10qPnCsp7TAPIeA0pYVQsvPfb3mLUqOXPPYF9Q3YYCt9K/kaPN0K8+R+aUROp1w582OnNqIKyZK2CoakJmhlys7oXhWe8cnbfFooLVDgQBlDeZune6YQknP/anMCbLBGiB/6vR/TnTTLKeQIhF7pPpaD2e1JMiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxfSvVwK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYFEpEGm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxfSvVwK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYFEpEGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787512380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dyMUHwcFZHWvzwaQJRcLCXJOSAtnM8sZrtYfPFtbokg=;
	b=GxfSvVwKE1oIuStO2RbrEdtJmbJXeAIwhYphZC/o0v7mer3b41NjBFIyWiI9i4k+Xw/0WT
	47BvdiQ61q9znndZtM01nwDtn40gFxJay46AzSpKWSztoYrOIIF6vxoL4r4aWcbd5xM5nI
	3UQmETCbsawy6F2O/3wea0BmuBcTx7w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-dKOWvUcbO1eSLk9MV2USmQ-1; Sun, 23 Aug 2026 15:12:59 -0400
X-MC-Unique: dKOWvUcbO1eSLk9MV2USmQ-1
X-Mimecast-MFC-AGG-ID: dKOWvUcbO1eSLk9MV2USmQ_1787512378
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8486c3411c8so3475833b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787512378; x=1788117178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyMUHwcFZHWvzwaQJRcLCXJOSAtnM8sZrtYfPFtbokg=;
        b=ZYFEpEGm0kfvoRel5A82MQqm4emsZPox/il/rqXogArEPU214HugAriGOeE75QRJPg
         c0FiZbw0J9T7/1CndA6zxWZlhqO+8AevmqUWEB3m/SU8XUZjnGw2I9HZRSOwDMtC17nK
         9Yq8a/q3uzmVMhCWC5qt/4XWm4gCaIDQUy0btchB+SKL7qP2TXb/uS2OjSo2vcS+3mDM
         ibLgjvjsCDVa2BJwSwVZzDCqCKuR9JXCZncAwB7xskT9VUzpTNjVJG/iARHagvrcLlWb
         A7MC66akhknG1lsVWhe5iqqQtJNEg/w/l0y5OvObTX+bFomJFg7EsPvcZQsSFa8Nw4V4
         w07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787512378; x=1788117178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyMUHwcFZHWvzwaQJRcLCXJOSAtnM8sZrtYfPFtbokg=;
        b=lyMClckkCgsL3ehZFpcVFVI3NZPbz16INsTuerTZzfrNTFoW8mPbKzDDPTCUO+XIV/
         oq2/PHb9HENKkjgCSBm1j3plT22pR0IjLricPFMl+EG6h6ea0SyIPb/XfSapKT+4Xl0e
         LN0YKcj82IsScAhF9EBBLVnWpaaclK/vgHBnxTloYUqezprKtVDUhxlwka4BCCgyRqbz
         Fjf77rrTp+E0zEK9rZsjiRsidGeM0GdFTDS6KzLcz77/gBXIjwDiHMH11VK9nOmXD7In
         MbTtbKQrtyZfpcVdYK4xvgKJADPachSJm6z/h0Facz8oXQh7E80kikvu1IxAhTbra78R
         Kw6A==
X-Gm-Message-State: AFuF++mTSIfad8UdHufBZ/9P68AgLa0lGZGnlRP/gGHzY8q5/0tmM4oJ
	Fs2eSEn+4IIB3xzrcJm6mqUj5pxD31UEc3Jlf98PSCFLlFTqKlN9nkcQd+YSRD4nfW5zos5VzKh
	qmQTDWgocS57qcV3qtFJXEx7j2XKR2HUPbOf+hFmSQxr6M2dG2emTaOpqFrvsQsAbrn8=
X-Gm-Gg: AR+sD10AA8WhBoY3fOUkENJDCyBOyTfB88ZZ2cEsQwUH2kRaT+BFxNYqrdNkTAUv1m/
	efnRDJpvIy3zvKZ7W+nNMKsOfIYxk/3vRsuGwAFfdyWlsXdzQi6m8xX9EEhkXxV3R8k29cutbNH
	iO3Zsfaw29/C9UBbE8gmoTY0hxZrv1B4v6ZyOLXVjwJVZ4BDnjosdo0NPWhzSc82U8ieRKAi8wf
	+TyyQiXlZGv4AlU0AATwowHDh0PxcXkjnfk/R6p695kqX8QAg0CSUKKUtX3e7jEmyBe8oFmKn7f
	1oqThNi8qk9Uciilv7qnYVe51PrupsbyVnrQdr6MywKcF69uFOlO25FYcOtKMZjG9GHk25nRaOc
	xcjzSV+5pyib6tY78x7ZkAwow
X-Received: by 2002:a05:6a00:bd03:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8520ba55d99mr20210451b3a.14.1787512378311;
        Sun, 23 Aug 2026 12:12:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd03:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8520ba55d99mr20210390b3a.14.1787512377847;
        Sun, 23 Aug 2026 12:12:57 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161701sm1224422b3a.53.2026.08.23.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:12:57 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] devtmpfs: apply mount options to the existing superblock
Date: Mon, 24 Aug 2026 04:12:53 +0900
Message-ID: <20260823191254.3696641-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
public instance") dropped the reconfigure_single() call that
public_dev_mount() used to apply the options of every new mount to the
single, internally created superblock. devtmpfs_get_tree() only takes
a reference on it: the options are still parsed into fc->fs_private,
but ->reconfigure is now only reached via reconfigure_super(), i.e. on
remount, so they are discarded by put_fs_context().

For example, systemd mounts /dev with "-o mode=755,size=4m,nr_inodes=1m",
so size= is silently ignored and /dev falls back to the tmpfs default of
50% of physical RAM.

Call the underlying ->reconfigure from devtmpfs_get_tree(), the same
way tracefs and debugfs do; ramfs has no ->reconfigure, hence the NULL
check.

This restores the behaviour of commit a6097180d884 ("devtmpfs
regression fix: reconfigure on each mount"), which fixed the same
regression when devtmpfs was first converted away from mount_single().

Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/base/devtmpfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index aef0fcc6aba1..f0798fc1bc34 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -80,6 +80,18 @@ static int devtmpfs_get_tree(struct fs_context *fc)
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
 	fc->root = dget(sb->s_root);
+
+	if (fc->ops->reconfigure) {
+		int err = fc->ops->reconfigure(fc);
+
+		if (err) {
+			dput(fc->root);
+			fc->root = NULL;
+			deactivate_locked_super(sb);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.55.0

