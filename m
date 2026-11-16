Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858155;
	b=sKBszcJqb8kDyaLIYnIa+40qRTttoZKxDQfq15HVlJ50aV8YEKy+wyRUSla/tVF3YPo0
	 mpN749l9nen6vTaA4whAXdxrqdgpF/PjixvPnCv4V8a1koylONZbP37wh9GDi3uZwSaWK
	 R4eF/ZnRAdd2BUOe7fLqmKZjYKHtT4IZns1qXvONwRMZx5WA+git7HC1gWcst2h/3xIcE
	 qUYfYjgViFqM/2lW9LrqI5+xLDNSQf6Kapq+wdf2RnqUWX614j+r0KqMcHPn6fwAlQ2zw
	 COpQCddWGsZuzs12+yEpkv0OWHpKxq7ErTahiH5U2u1A7KyJ+0R8AhgiB36iXRLx68w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3I26m1ZKPLTjPvcX7e66pLAPs7pMaHA7M5eZgrT0FBw=;
	b=35ndjbU32vZPmaC5JVSw6puk3/K7lH29py6pNTogqjtj2trRyW7NOt9ASbfe5lAjVcmi
	 ZeFusqiXKnHZttv3s9EAj6NCwV6RLPc3R1I1fsuyEpKyOXIw1Cq6TgmzcHtmdTSsx6DMo
	 rSyxskiRE26gbsV1llzM3oQHdjudMspYf4naABp/m75WY4DEzWJZYLiz42tMrGHchBO0u
	 QVLyDawDx+V3wgjiVp7HuNOAsZgxyeP9NxCbJ99Byp+IbZ88oA/aHEmvukiTAtbc0XSnI
	 K4XKwhFE3mA/ZPoTrj3rVHIvq0etfBGdhI4zzHmYH7M9daVz+LfGfnaO+0PU4aa7vDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXpk2RTu;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA0606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69EA0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXpk2RTu
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4910b863b84so123122f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858154; x=1795462954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3I26m1ZKPLTjPvcX7e66pLAPs7pMaHA7M5eZgrT0FBw=;
        b=qXpk2RTuQatVkqGl/4ukj2niDuP7xReXALWCWwisqQwQqzo4Vf2AcQXNYTHeo/e3as
         Xp8ogURkEfgco/CkyKmA58PQZI2A+r7IJ04lEpDBGn7QP+nQzbomQo+WJUx0Z2XAbJGJ
         LBUua0zBhiNyUVi9o0GWXYtiBus06ONFSLFvsWE3Sh3pKEjDQZvR6kDnwO88SFjoGJZU
         FuMjhm+sZO0n9tIPDwVE36U+qgCxwhkzzHCMk69DbdI3cCGJzlngeKdLCT7mfX3Pkhet
         DJoqe7PnoBKXdzdT53U4uadDGtRM5zNR+5juOhEcBi442KbFe3Kuj1LBO4zUldL90WiX
         wKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858154; x=1795462954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3I26m1ZKPLTjPvcX7e66pLAPs7pMaHA7M5eZgrT0FBw=;
        b=bZEQ3vT146HLmkBaLLBkNVXsGkV/Y4nTJrgc1xaW+0aZBS6hQ82G79yG4MFsgBcD94
         zn54h5WM9UD1TnqYW+d8KxN2Y1vJea2aj5BQ3xruZvSPrD4/Ai6lxiQQB68iKOT/Y5jl
         ss6J+DzmL1JSvHvzahkkZrYUSyAtdwO/PdeT9KTQWCgZkigLOQDuo5TVLNliEXWB+Gto
         S1QTeNtcdb95aG4sYmtvJx7Wtm/qQQsXt1EWUGWBTkv+CMBupTcb5Wjrf263LJr6IKD+
         o1nucnvcxuuk4YHIVJ2wwponzPYXdLaiSi6QEDS1hflPGyy9G/4MaD19GSP2170+6rBr
         TE/w==
X-Forwarded-Encrypted: i=1; AL+hErE6UCNNkU7HMXjQeTUjAFvUFyU5aIxL/TCfV9u+1Kf+yw6fpkK+qzE16xxSXW/izDn37moyGVl/GgG5Ug5d@vger.kernel.org
X-Gm-Message-State: APuU4Z+bEo8q1AyPhifaEBW639LnturIbaKvZO1m0+cn2g1JDtZQmBTX
	oS9u2Ityws3l+ZKo2bGBJgjZ0uNlsmoy9t/qqAw0Tt56mTO2ZPhZH1yLrvD00U0bimA=
X-Gm-Gg: AZFdTZeVxgWDTDXCHECI7COVmTc/DjedYJknOL9avGMY5irVr3wjmjTyR+m9xW1Jll/
	p2lUI0SRPuJ+8aM5FaD53W5h6FNelepcTJ2dSrCF6kkhDb6fVwRlsXPf/AYglHOOn8gS52fiaqE
	sq8LiV4K5yaUd0+GQZSwPoW/251EKDV8moHsyaxel1yPxmuZefdypFnJ/fYqsKO10q/e4v6sWV+
	2njWpIWFKrGGOmlOm9Q0J+mOi4M8sfWEKhs70dmHU8l/Ms3N3zwHW0es0foruac8DCs3c40Wu+/
	QepDEeidLyyX7Wwr0xIdlv19H3vthnkRp9LdHUHHbvZPpAGDCyCq5tFLOvgLVF0cByJEwg2i5c0
	CLe4hXi/fkRvCR94RCZ28hltLzpV6x5QX9vfHv+ofY6x9VLxBeb03F0ddrCdqrIVAFf9lOaWn0t
	7aSLupP3o45qG4Gr3ygwNaBL7eBjOOW+Mw20xGj7QdQ+6HeadDyhuo/o74VPy6vlKI+P0v6FPUs
	fvUHS23JxfpXgb6A2LUcpY8lfChLxKKrkPc0zR1P/7eRbL7MISeTZNBKC3wDZOfnrqDFd8TFNk3
	iD7uxFprCYk0flX/t8+vs4cK45baMUJyr/pJmvTxNysbAEqgyURCod4Y6GOqiXcimZVo05MvckE
	zT188HP1xFkSES2jov2Jdx4RbvWbjy1zZcGc=
X-Received: by 2002:a05:6000:460d:b0:492:9c9:65de with SMTP id ffacd0b85a97d-4a36bd51e25mr1195437f8f.5.1794858153672;
        Mon, 16 Nov 2026 11:42:33 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60d9fff8sm25294154f8f.52.2026.11.16.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:42:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/ovl: test pseudo filesystem upper and lower with data-only layers
Date: Mon, 16 Nov 2026 20:42:32 +0100
Message-ID: <20261116194232.940309-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

A pseudo filesystem lower layer is now refused along with data-only
layers and a pseudo filesystem is refused as upper layer.

Split the lowerdir_sysfs test, so that sysfs as a regular lower layer
is still expected to mount, but sysfs as a lower layer along with a
data-only layer is expected to fail.

Add tests that sysfs as upperdir is refused via legacy mount options
and via fsconfig by path and by file descriptor, and a tmpfs upperdir
control test.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This applies on top of your selftest patch [1] and adapts it to the
expanded ban in "ovl: refuse pseudo filesystem layers in some setups".

On a kernel without the pseudo series, datadir_sysfs,
lowerdir_sysfs_with_datadir and upperdir_sysfs fail as expected
(sysfs upper falls back to a read-only mount) and the rest pass.
I did not test it with the full series.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20261116-work-loop-pseudo-v3-34-8cbbea1cf34f@kernel.org/

 .../filesystems/overlayfs/pseudo_datadir.c    | 83 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
index 3b59fd3e9f5c2..903c893d7b4c8 100644
--- a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
+++ b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
@@ -22,6 +22,7 @@ static int setup_tmp(void)
 	if (sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL))
 		return -errno;
 	if (mkdir("/tmp/lower", 0755) || mkdir("/tmp/data", 0755) ||
+	    mkdir("/tmp/upper", 0755) || mkdir("/tmp/work", 0755) ||
 	    mkdir("/tmp/merged", 0755))
 		return -errno;
 	return 0;
@@ -60,6 +61,54 @@ static int set_layer(int fd_context, const char *key, const char *path,
 	return ret;
 }
 
+/* Mount an overlayfs with the legacy "upperdir=" and "workdir=" options. */
+static int mount_upperdir(const char *upper, const char *work)
+{
+	char opts[256];
+
+	snprintf(opts, sizeof(opts), "lowerdir=/tmp/lower,upperdir=%s,workdir=%s",
+		 upper, work);
+	if (sys_mount("overlay", "/tmp/merged", "overlay", 0, opts))
+		return -errno;
+	if (umount2("/tmp/merged", 0))
+		return -errno;
+	return 0;
+}
+
+/* Create an overlayfs with "upperdir" and "workdir" through fsconfig. */
+static int fsmount_upper(const char *upper, const char *work, bool by_fd)
+{
+	int fd_context, fd_mnt, ret;
+
+	fd_context = sys_fsopen("overlay", FSOPEN_CLOEXEC);
+	if (fd_context < 0)
+		return -errno;
+
+	ret = set_layer(fd_context, "lowerdir+", "/tmp/lower", by_fd);
+	if (ret)
+		goto out;
+	ret = set_layer(fd_context, "upperdir", upper, by_fd);
+	if (ret)
+		goto out;
+	ret = set_layer(fd_context, "workdir", work, by_fd);
+	if (ret)
+		goto out;
+
+	if (sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0)) {
+		ret = -errno;
+		goto out;
+	}
+
+	fd_mnt = sys_fsmount(fd_context, FSMOUNT_CLOEXEC, 0);
+	if (fd_mnt < 0)
+		ret = -errno;
+	else
+		close(fd_mnt);
+out:
+	close(fd_context);
+	return ret;
+}
+
 /* Create an overlayfs with "lowerdir+" and "datadir+" through fsconfig. */
 static int fsmount_layers(const char *lower, const char *data, bool by_fd)
 {
@@ -123,9 +172,37 @@ TEST(lowerdir_sysfs)
 	ASSERT_EQ(setup_tmp(), 0);
 
 	EXPECT_EQ(mount_lowerdir("/sys/kernel:/tmp/lower"), 0);
-	EXPECT_EQ(mount_lowerdir("/sys/kernel::/tmp/data"), 0);
-	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", false), 0);
-	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", true), 0);
+}
+
+TEST(lowerdir_sysfs_with_datadir)
+{
+	ASSERT_EQ(setup_tmp(), 0);
+
+	EXPECT_EQ(mount_lowerdir("/sys/kernel::/tmp/data"), -EINVAL);
+	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", false), -EINVAL);
+	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", true), -EINVAL);
+}
+
+/*
+ * Without the check, sysfs as upperdir falls back to a read-only mount
+ * because the work dir cannot be created.
+ */
+TEST(upperdir_sysfs)
+{
+	ASSERT_EQ(setup_tmp(), 0);
+
+	EXPECT_EQ(mount_upperdir("/sys/block", "/sys/bus"), -EINVAL);
+	EXPECT_EQ(fsmount_upper("/sys/block", "/sys/bus", false), -EINVAL);
+	EXPECT_EQ(fsmount_upper("/sys/block", "/sys/bus", true), -EINVAL);
+}
+
+TEST(upperdir_tmpfs)
+{
+	ASSERT_EQ(setup_tmp(), 0);
+
+	EXPECT_EQ(mount_upperdir("/tmp/upper", "/tmp/work"), 0);
+	EXPECT_EQ(fsmount_upper("/tmp/upper", "/tmp/work", false), 0);
+	EXPECT_EQ(fsmount_upper("/tmp/upper", "/tmp/work", true), 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.56.1

