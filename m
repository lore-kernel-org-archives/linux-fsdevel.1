Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610053B19AE
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911520; cv=none; b=qwh+KhnoUuV4eB1OgOszoqLbga3qOP5YrAmnG1bLBw8Dbxe/biIyQ+rEMAo7jmnkkQ0N/OeTl07hLjHXc5q98EROGXF5qZxNFv5jZcISbjItx548AahkjKf6ii/dnLan1AlTTil37Edy+y944Y9ZnauBUK1ljiftCXFikrIr9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911520; c=relaxed/simple;
	bh=kCl++7kVYFt/ccvpD4rkLQoby1VrrRSqMkxpEBLSpA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWoAQJTQy/HFidygP6MqD255Iar9exGxWLt3olLtg2/167YqCEnx/U4HWq+60TFpEX4JujKzSllFmvs0UyeXYKZUfm2cu0AH1NLNfSXDKDoFuV9dUyMfPZIRlnOK1HGOL+G3jhz5LcnibcTD274c+4eNcMWwgBaDRpraUlKXDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0tOkv30; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0tOkv30"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137335bc3caso2993385c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911518; x=1780516318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Sp+s7C7f8D+jwwDxh0Y9qxUvL34f7v6oQb0ido5j04=;
        b=c0tOkv30dFFMOs8lQI7MqrKFPpuSGUHCXUY0W0d4Bzgc+Jvd/y3VR/qfrQF6Dxk3Nj
         XcueQNIxEDBPxc+v4abjlF1kFNAvJ5it/qCGT5vrs2rsSeki0LEGg3XJDxn2kWP4Qa0c
         r9aptGyWYN6aBYJ4OK5htdqYve3Z36WtnWzivYMp446V+GeT3dh7QpEZ0xAwlNkXtaK9
         +B1ixPm8bRDPVtb3Ktbr5dkDJm7W4zOaLP8Mhp3kJw6r41/bsquLLktSV1AtX1YxR2UZ
         qWQ0Z/ePiAXANRPy3LszmpA+AowH3R/Pcqpn3SbpBjynXDVp+Vj3ecEx9KK3UsG8xjjO
         Dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911518; x=1780516318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Sp+s7C7f8D+jwwDxh0Y9qxUvL34f7v6oQb0ido5j04=;
        b=DpttkV9yMJaJJOgWjyNa+CKpNkq0NtloeLBwXHi3sVkWg6lGZuegr5+vP25GIOnscZ
         +ip5ejlIyXooe0USx2b2EHtW+40eWb7h7EYLX3MFX9ScToBNdkfu2T3cjUlaMbst+uqa
         3NieBwv5S02ni6LKpyuODtprXBXvANogn74Unohyya5mTPwiHXUMvv/XaXiZ+c7zbHq6
         1aGafiG7CFTMLzd5aDKnvKDYa2Qx/siN6Et46MbtV0G6XjDPEIeo2M7k21aGl+7PubMK
         nXDxnWV+u5c+q0UNf2bqhN4SjKu4+zKs4y0BXwo7/DlShTYW0dNpfT17Zt7RYJvcOSo6
         5sDg==
X-Forwarded-Encrypted: i=1; AFNElJ9D7p+mJgwPmVol2jKJKw+p0MHbbYXZPwilTu8lNfPuqO9F1GmswRiAFTxt9M/X/7VgxRGOor5X1LGy8eNH@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuycbsFpauB1gUANfoMN60aPqIFXGbQDfBxQ5e7/19MFhfqev
	RSaDkpSGNF1zM/Fz2ccqGfLo7Xdp6dqieBrJ0v88Ck9noCNn4laNvLrI
X-Gm-Gg: Acq92OHpd9+uOzgBxN1eB4O+fgBSRw45ng0+FrDgJ5W14C4RUCcu2+8K2nK5eWN3r4C
	PY214izMKuomTpyJjMVzS7cvrxArvSPcN/qkyHZjjDpK/QXdHGejdrz4DMOzwqxmAhCCniU9T3Y
	cQvKBSQziV9NHwu5LwJupIr67tGMPv4wVSzz3gEUh+eZxNaNj39eVwNuoOK7mzxOoI/m9cnMU9P
	CfJ4A5C8TOSoxSh8lJLiwyGgKxE5Ok4uBP7aqp6hXK80n2IOl268d+O8wJF4aCGuNrJU9NggNHd
	t8w3cx638M/y3s4nP6mBJb9oog3KfYsS0IaNPx14ovJ9H7s6gm5rKN3yaDMXjLrkv17KoLrP/1V
	0DcnorJRynIuywuWEfDZWk5e2CvwKZ1/y2rb+6w7Xv1RDjmI5BcnSLtFMLIcJ2ltHJI+hGyNgZA
	p3XlutjJ+wsK4aP0Sn9yaGDBhrvwyKeA==
X-Received: by 2002:a05:7022:61a0:b0:133:3c47:92de with SMTP id a92af1059eb24-1365f812367mr9061282c88.17.1779911518387;
        Wed, 27 May 2026 12:51:58 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4719sm13705106eec.1.2026.05.27.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:51:58 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: pvorel@suse.cz
Cc: amir73il@gmail.com,
	jack@suse.cz,
	repnop@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ltp@lists.linux.it,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v2 1/2] fanotify: fix crash when running multiple iterations
Date: Thu, 28 May 2026 03:50:55 +0800
Message-ID: <20260527195056.337081-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072312.GA231966@pevik>
References: <20260527072312.GA231966@pevik>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes ./fanotify13 -i10 crash by restoring the deleted objects
every time a test finishes.

This commit also fixes ./fanotify21 -i10 crash by remounting the read-only
mount (if the mount is remounted read-only during the test) back to
read-write every time a test finishes.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

On 2026-05-27 09:23:12+02:00, Petr Vorel wrote:
> @AnonymeMeow nit: if you put whole conversation after --- (below), it will not
> be part of the commit message when one applies the patch. And here should be a
> proper commit message.

Thank you for pointing this out, I will be more mindful the next time
(this time).

> Also I found that fanotify21.c on the current master fails when running more
> than 1 iteration:

Thanks for testing my patch, I didn't know that the standalone test binary
supports the -i option to specify the number of iterations. Running
multiple iterations through kirk's -i option seems to work fine.

I then tested all fanotify tests with the -i option and found that
fanotify13 also crashed when running multiple iterations. I fixed both
fanotify13 and fanotify21 in this patch. So now all fanotify tests pass
with the -i option.

With Best Regards,
AnonymeMeow

---
 .../kernel/syscalls/fanotify/fanotify13.c     | 20 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 13 +++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 76d40eaf7..540e0b483 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -137,6 +137,16 @@ static void delete_objects(void)
 	}
 }
 
+static void clean_upper_dir(void)
+{
+	unsigned int i;
+
+	SAFE_MOUNT(OVL_UPPER, MOUNT_PATH, "none", MS_BIND, NULL);
+	for (i = 0; i < ARRAY_SIZE(objects); i++)
+		SAFE_UNLINK(objects[i].path);
+	SAFE_UMOUNT(MOUNT_PATH);
+}
+
 static void get_object_stats(void)
 {
 	unsigned int i;
@@ -340,6 +350,15 @@ static void do_test(unsigned int number)
 			"Did not get an expected event (expected: %llx)",
 			event_set[i].expected_mask);
 	}
+
+	if (tc->mask & FAN_DELETE_SELF) {
+		if (tst_variant & 1) {
+			clean_upper_dir();
+		} else {
+			create_objects();
+			get_object_stats();
+		}
+	}
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
@@ -417,6 +436,7 @@ static void do_cleanup(void)
 	if (ovl_bind_mounted)
 		SAFE_UMOUNT(MOUNT_PATH);
 	if (bind_mounted) {
+		delete_objects();
 		SAFE_UMOUNT(MOUNT_PATH);
 		SAFE_RMDIR(MOUNT_PATH);
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 340fb0018..2e3dbd4bd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -199,7 +199,7 @@ static void do_test(unsigned int num)
 	if (len < 0) {
 		if (tc->remount_ro && !fd_err && errno == EROFS) {
 			tst_res(TPASS, "cannot read event with rw fd from a ro fs");
-			return;
+			goto restore_rw_mount;
 		}
 		tst_brk(TBROK | TERRNO, "reading fanotify events failed");
 	} else if (tc->remount_ro && !fd_err) {
@@ -346,6 +346,17 @@ next_event:
 		if (event_pidfd_fdinfo)
 			free(event_pidfd_fdinfo);
 	}
+
+restore_rw_mount:
+	if (tc->remount_ro) {
+		/* SAFE_MOUNT fails to remount FUSE */
+		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+			  MS_REMOUNT, NULL) != 0) {
+			tst_brk(TFAIL,
+				"filesystem %s failed to remount read-write",
+				tst_device->fs_type);
+		}
+	}
 }
 
 static void do_cleanup(void)
-- 
2.54.0

