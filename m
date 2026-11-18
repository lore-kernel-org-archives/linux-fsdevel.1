Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987071;
	b=nmFOK+zu+z5xkCl8WAmmgRf084weP6NAaFPYNrYnHZrpIb0HE6OdiXmt6E46YHb3hDaB
	 0SWGEPo2mpLRSWwKbNjFqDYiHaHw/Fk0BstB932le8V4vg6peupVjsPP4rIANx88Onvr2
	 OyerbND4RANBm4+a58PI8hDSYenVYfwixR3DnHW9NfPDKn5nkyRN38ujfIMQsxKDqrw7E
	 Tp7M2DCutcZScCQb1xV/9zKpzt51pSjs79UQQcGEZLGdXepaDTlFVUhLWMyrF5smVe9Wg
	 IuCRzVUk1G0cXZxGBqaGKE37eN1ehUXeZNAfGUg3HLzDQknRWOrmxJ2ueMEJjxDy8tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eWg2ssMtvIjbIBVfzFep3SE3+iPeF+XqsCRhDsgdD4k=;
	b=uVfV8GAA4PjaJGKTLYhft0EwIRhcEb4V6CgtTcKPmIQhIEljIiOSrxT0HuegLF/fqbrH
	 g2bE+BybZbfmfmPfBss7uxqh4AufoCfuuO1KmqVP3UMu8+zYljUonbsAH6xL16y/hdiQV
	 w+5vim3S89kWbqNOCnrTNwU8Slt8QKrJSnuM/AoiYe6jN9uoDr+ksmH0+VWBh6uKi7VhS
	 p2N67eXtAzPH5UrfWYtJDaLNksPj4k3JiNCu4DVo26gF6MfD8pexjbPUxXGocMGE+tImt
	 ghWGj41230vElZk26/e0D8Ir56hpMbWSM6Q1gC5h5VWCQi0ixT0eXbKs0i+XRTlUO3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWmhIIRD;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D91606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D91606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWmhIIRD
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso785495a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987069; x=1795591869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWg2ssMtvIjbIBVfzFep3SE3+iPeF+XqsCRhDsgdD4k=;
        b=MWmhIIRD3Fy0LOzBmUnWjbs8Lo0zSV8GYtJcbFvA1X99ETY02Wrn/p62M+TvcPbjNJ
         b77klc5BcMSnN6Y8RwjQ6nUCbM01r0uIsDywhKfNjRVWIf1x84rzxqfMPZCOq8elxc3P
         0RaNJvHHa4phE9GvQ1lxOof1Ybgt+gh8dKDelcVrUlahN0AHkrffFVlH+bl/g2vrj/Nz
         Am4jn+obGdEFLWaZwBaEeJbFW6BEQ4AKvt8qz8YrZPxrgTtMehxE1OHF0smXhYUfGqqs
         zsUP9585fNuAy0pbkImHOBx/b/HfyEImMOiru/hCEms1GIVXYxvbuf1+P5bH1bDBhllU
         6b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987069; x=1795591869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWg2ssMtvIjbIBVfzFep3SE3+iPeF+XqsCRhDsgdD4k=;
        b=l9pN/BXr4OLjf3UjmY05lPOuHD7zDGaEiAZxvHfQd52HIZun8LZV7rsWKPtQLvN6f3
         Vqo9yZBf1Xo1MWtVg5YTEHwMTDJ8nIhZOX/wC1+MYE7Vp9UYbvpOQNhKK+RkxTI1bH2r
         8qpx72qKGQWD7MaW9u6KOx3oTg+S3KU0EEf2cH5/7GmqsGAgdMAftarCkwsOvHRzRG/i
         8IoMYfdTU7/nVFKm0CKQk0tCNtJGEksGp/3TXnLBRSU+qVfsFiIPFSWNbQvZ4BBnStuf
         R+NAcLRS70UsbtNiSBIcNDr1rG3ivsCIe6MeRSg7W4rzmTiskbi/dopF8axRQirdjxbT
         /rgg==
X-Gm-Message-State: APuU4Z92pnNF3aJPL4+aXFrKB3wG80V+tzprbv+mGmwSKZgv/OsTF36m
	KizzNlq9bGxPi6xZXwLI+eiXgwcdZK4/KprjZcQraFDXa17QSoj126NC
X-Gm-Gg: AYBFou1KqPReDEk+LbLMaOVn3PgHygqWrKALNEF5qs0LZ4gqDNofpnX8HWx0u60Ii49
	DmXYuMEgW35PV5JtdvazrvoPvSXK/1NypX417yMVC3s2/NCT/l56MwrCUucq2o/Bhx0EyNJuTOi
	ghoQa8t1Mpy2i4F9kSqrFC49GLZhHtunaCaqJeheNyI4Naox3NCSY8o0X+22/TKtFz+PwYS2jDh
	fQVOum12vpAY896PZS3nRSd1Ipnz62MGqWum70N/czWt2XYJtF6rucxoVyes587mrPhiVt1wetW
	Mv5tMgnJcaH3rDO68H4bkhPduKD/ZMXMP4rPkgycNYyVcEIfSVoomEPoNJXKM8tMrsO8JZNRX1D
	hbp2QCqTv33R8VSGiFFCwXuwDFECoJK+oN4VFbOLVYdjRwkOp44tfoQkwizNGwntviSkTO/9Zx7
	O1zZd92Bo9cCPPU5KPuOJN/I0rzeWmpsPxvacWCS7Y9b5j5PEJU8FpFMcA7VZtKgcOhfRcuz5wG
	QV0FcWZfYkAQsogwu1mbf7vrQ8QLYns9X/hwBKXn7Ia9BrHVL1OK7dq4GF2+eN+HMD96pFoPtvk
	EcU8N0qdH9iIaPaFRQzFBnvRJiGSD/y8kI014aUVXUZlsCYb5vhoABq29O6tiLIQ/MrnbGMTUmi
	sLshpbcwWs38g
X-Received: by 2002:a05:6402:a6d0:20b0:6b8:77ad:62e8 with SMTP id 4fb4d7f45d1cf-6b887f16331mr752541a12.44.1794987068266;
        Tue, 17 Nov 2026 23:31:08 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c2379asm704171a12.17.2026.11.17.23.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:07 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 5/6] selftests/ovl: test pseudo filesystem upper and lower layers
Date: Wed, 18 Nov 2026 08:31:01 +0100
Message-ID: <20261118073102.1216568-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118073102.1216568-1-amir73il@gmail.com>
References: <20261118073102.1216568-1-amir73il@gmail.com>
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

A pseudo filesystem lower layer is now refused along with features that
do not allow offline lower changes, such as data-only layers and
redirect_dir=on, and a pseudo filesystem is refused as upper layer.

Split the lowerdir_sysfs test, so that sysfs as a regular lower layer
is still expected to mount, but sysfs as a lower layer along with a
data-only layer is expected to fail.

Add a test that sysfs as a lower layer is refused with redirect_dir=on.

Add tests that sysfs as upperdir is refused via legacy mount options
and via fsconfig by path and by file descriptor, and a tmpfs upperdir
control test.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/overlayfs/pseudo_datadir.c    | 103 +++++++++++++++++-
 1 file changed, 97 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
index 3b59fd3e9f5c2..954a9f25cd1c5 100644
--- a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
+++ b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
@@ -22,17 +22,19 @@ static int setup_tmp(void)
 	if (sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL))
 		return -errno;
 	if (mkdir("/tmp/lower", 0755) || mkdir("/tmp/data", 0755) ||
+	    mkdir("/tmp/upper", 0755) || mkdir("/tmp/work", 0755) ||
 	    mkdir("/tmp/merged", 0755))
 		return -errno;
 	return 0;
 }
 
-/* Mount an overlayfs with the legacy "lowerdir=" option. */
-static int mount_lowerdir(const char *lowerdir)
+/* Mount an overlayfs with the legacy "lowerdir=" option and extra options. */
+static int mount_lowerdir_opts(const char *lowerdir, const char *extra)
 {
 	char opts[256];
 
-	snprintf(opts, sizeof(opts), "lowerdir=%s", lowerdir);
+	snprintf(opts, sizeof(opts), "lowerdir=%s%s%s", lowerdir,
+		 extra ? "," : "", extra ? extra : "");
 	if (sys_mount("overlay", "/tmp/merged", "overlay", MS_RDONLY, opts))
 		return -errno;
 	if (umount2("/tmp/merged", 0))
@@ -40,6 +42,11 @@ static int mount_lowerdir(const char *lowerdir)
 	return 0;
 }
 
+static int mount_lowerdir(const char *lowerdir)
+{
+	return mount_lowerdir_opts(lowerdir, NULL);
+}
+
 static int set_layer(int fd_context, const char *key, const char *path,
 		     bool by_fd)
 {
@@ -60,6 +67,54 @@ static int set_layer(int fd_context, const char *key, const char *path,
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
@@ -123,9 +178,45 @@ TEST(lowerdir_sysfs)
 	ASSERT_EQ(setup_tmp(), 0);
 
 	EXPECT_EQ(mount_lowerdir("/sys/kernel:/tmp/lower"), 0);
-	EXPECT_EQ(mount_lowerdir("/sys/kernel::/tmp/data"), 0);
-	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", false), 0);
-	EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", true), 0);
+}
+
+TEST(lowerdir_sysfs_redirect_dir_on)
+{
+	ASSERT_EQ(setup_tmp(), 0);
+
+	EXPECT_EQ(mount_lowerdir_opts("/sys/kernel:/tmp/lower",
+				      "redirect_dir=on"), -EINVAL);
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

