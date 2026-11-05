Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890702;
	b=ULjDQDoMobRLjJR3ygYKrVrFYYTHyUpnkkW/ug2MqzkY1s97MYgyr8/q7Olk4qFfMuZr
	 1eStaPme8NWB3GwOnfaFiEDB70l4JJENe4AS7Qu9+ObrwHuPMq2zA3yd4z5rop/rDRAuL
	 gJaWZOxJ99akcdWCSqtOL4kxyJ1Ysayx5fj9JtyLml56mHbHnDCqGRXbADZBVW31veJst
	 27Ee2NpAmYx79F6lSM1SBSP8x/b8QxDy3t7MPL9QBRtveMh/JXkOzErQCGZdXKv3/XNoJ
	 rxgmKxfbFMsd81C9uxFeP2u61SAeoOD6hd2a/oZxdsFdym+VoKAuh9mcJ2zIRXwosMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YD4MKzjuGqaVW34jYm41tg1pLvXJAa1EZJPAY0d5628=;
	b=ozbyjn4EDvVT6fd2iURAMBgkBLbT6I5p37Y79owbqCBPJigW7GBaOgl1pcStIS8kSmOI
	 EkJQKAvX+o4UWjOv+8wPjjupfnAbIi/zGatrMx7+pDQNjxFg294npSzwvvSuALZSl24qf
	 KgtCtHGuoFvNpPOTn1am33+rsk/gUFAXo0bDVmyjvqfGXdxEjYU1slp/64ZTg4xSWd+Mw
	 OZel8JecaiHpAeevK8dnBfczP7TzTYAShsQ0f5acoyfQaEaXZI6dDNUGSY38O7mnCe5UR
	 JYkPd4DssXB7o/Q9zTSJTEFCvJa3aqLijKo5L9csM1Tc+bDSNym8PNE+VjZFoPuLaoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=clholjk+;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AE606D806
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0AE606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=clholjk+
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-82109f51565so854029a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890701; x=1794495501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YD4MKzjuGqaVW34jYm41tg1pLvXJAa1EZJPAY0d5628=;
        b=clholjk+NpSEYKTt4ABkOe0qowBaAriDH5iE3ssE6sCYPBAnTHzVV0dHXXf7rU1Mxa
         Euf6f8RXCQxQaioBZROE7lSTSNHWlTJVOlCA2wW4RbtVhzWujc6x+3MbE6MUQbXoBo/R
         5JiwAz+soG1TNJ8QzZPd0+96EG+GOVMvMbU7FsmrR9sGq+Qfk7tWnhDiGJYUEIf+poOb
         ZnyMYMw8dSh1mm+ATTbseRYMIrORGXqeSSGlJIBKx2ICjSAGScb2Hi2HvV71NtIsgjJt
         39TYguwxRwzuadshz/7LUJ/Qb/SpZBLB9A8orIONj3GSZ/YZc2BoBacvqXOq5KOmTSve
         qkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890701; x=1794495501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YD4MKzjuGqaVW34jYm41tg1pLvXJAa1EZJPAY0d5628=;
        b=ZnSx1SRpLe35eq4t+W/rbuvyWSMeVNei5ZpNoIy/KL7SNQ4rieQ8/u+re8p90uV3nc
         ORF4K9m/pKndSvXzvAmrQeBmtlBSGAChrvwHyszxBFS1P0wnQ5vKtyopH2psqG6YB0rc
         eYWJoCM4gjUQ+3uV9oQEk3t/tjJWbbBwRZUV4yQXwvFVqSGAe2wQ9EJgB7Ny30TlkC7h
         4Ng7JVnT4gk3tLCuPMUK9ldKPBkhcgqypyhZ5c5ZXUrRohqPA/w2NCInwjxhkD0qGO+a
         hLCsONOE7c8tvmgeYwH00PyPTV2XAKPvX5wcP5zdur2Gt/iDOXtmChpcnMZDs7RMhAJu
         w/aw==
X-Gm-Message-State: APuU4Z84oq3LYAZvxmS2i/v3AMPIaVy04MZ9qCLZOlZKZQuNVo61BkQh
	AQHSzmi9/BvgzSx20MXDY1APb10zgDRQ5ePQeOogmB6nhUDmxSHqY5vdBKkyLWmihAk=
X-Gm-Gg: AYBFou3oBTHjM1CBaSqD04Vl8Zm/fjQFIUbs616fBH3QvTOpKBEzmXedJFvPpWeBZ8D
	MyTWof18JbmvSOJFvF6DDcsIZOArYtr/2JMhrChrjLYrsmT63z7jrh9onAXy5zbB0rGD3E+VblS
	ljwyfCZQLHKmR/S/MvLL202v+6ersdICIErMVbXgmYz3N6wbaaVTSrY7bs6X4CeWjbVOzxcOQiR
	089vRlUO4FNrfQUPGDT8lbtdibwkrs0ivn4Hi4TxpYWDwT8Bc5EFH6+XsryOrnTZKNZxUGC2oiY
	b+VcDNB+ryJhY/j+UWpxCDT8Yn4zOa5irftoLYuaqmOa0s0y02vkJ2PHtCtz/ZdjtWu9vnawYFU
	0i5kw8Lv7Ydge2qf3/wscGsEf1CrRiZ1a1mwECvoKpDgcWn7HJM2p0uE0yEEYBR0YjWv5mOrc9S
	7NcoUpMjzNNerLMlGCxExm3WkeUkocPAijRH5XO3BfrZ33+JsuQVR6groyIlrWfqKt5B5CzB5GK
	L56qtKyAHwsynfSWhUTCqJEWiFNfC3jbqg5RYRoNOa1wHXyd89nSv9VXzD3pZaX4xLt3AaAdgcI
	JdHtJcg+he7Z8GEbtYdZ5Mk3Zf7210TWI9GzyemYvEx1YQ==
X-Received: by 2002:a05:6830:4391:b0:85b:c75:dc65 with SMTP id 46e09a7af769-85d364a5597mr16805624a34.7.1793890701047;
        Thu, 05 Nov 2026 06:58:21 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e74f50sm4721807a34.21.2026.11.05.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:04 +0000
Subject: [PATCH RFC v3 13/90] fs: never store an id that was lent to a cell
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
Message-Id: <20261105-b4-cells-v3-13-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=5662;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=db1fPjvY2edvd4YYcZ+XdOK2IgL0ZatDWIixhMxnSdA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPngFOJfoyKpAK4teTG+textNYYmHTtI8NzAnwvzi+U9vftpCf0pFYYs4jGbzYzWdO0tSt3qoEy
 R/FiJ8v7G6wY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A block of ids is lent to a cell for as long as the cell exists, and is
later lent to another cell. Anything that is still owned by one of those
ids at that point would belong to the new cell.

Today a task in a user namespace can create a file on a host filesystem
that is not idmapped. fsuidgid_has_mapping() only asks whether the user
namespace of the superblock can represent the kuid, and the initial user
namespace can represent every kuid. The raw kuid ends up on disk.

Refuse to represent an id of the window in a filesystem that the cell does
not own. Do this in the helpers that decide whether an id can be
represented: kuid_has_fsmapping(), kgid_has_fsmapping(),
vfsuid_has_fsmapping() and vfsgid_has_fsmapping(). That covers creating a
file, chown, ACL entries, copy up in overlayfs, and the uid and gid mount
options of tmpfs, fuse and bpffs.

A mount that is idmapped for the cell keeps working. There the id has
already been translated to the on-disk id before it reaches these helpers.

Some details:

  - The vfsuid and vfsgid helpers do not call the kuid and kgid helpers. On
    a mount that is not idmapped they do not check for a mapping in the
    user namespace of the filesystem today, and this patch does not change
    that.
  - The check looks at the value of the id, not at the caller. overlayfs
    creates files in its upper layer with the credentials of the mounter
    and the fsuid of the caller.
  - The check is not in from_vfsuid(). That would give the inodes of the
    kernel internal shmem mount an invalid owner, and notify_change()
    would then fail every ftruncate() of a memfd.

With CONFIG_CELLS enabled, the host can no longer chown a file to an id of
2147483648 or above.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell_ids.h      | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mnt_idmapping.h | 13 +++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/linux/cell_ids.h b/include/linux/cell_ids.h
index dcb0a559d0e9..9bdd98e73a9d 100644
--- a/include/linux/cell_ids.h
+++ b/include/linux/cell_ids.h
@@ -62,4 +62,42 @@ static inline bool cell_range_in_window(u32 first, u32 count) { return false; }
 static inline bool userns_is_cell(const struct user_namespace *ns) { return false; }
 
 #endif
+
+/**
+ * kuid_storable - may a filesystem store a kuid?
+ * @fs_userns: the user namespace of the filesystem, sb->s_user_ns
+ * @kuid:      the kuid, after the idmapping of the mount has been applied
+ *
+ * An id that was lent to a cell must not outlive the loan, so it never reaches
+ * a filesystem that the cell does not own. Through a mount that is idmapped for
+ * the cell the id has become the on-disk one long before it gets here.
+ *
+ * That @kuid is an id of this cell and not of another is for kuid_has_mapping()
+ * to say. Nobody but kuid_has_fsmapping() and vfsuid_has_fsmapping() has to ask.
+ *
+ * Return: true if @kuid is outside of the window, or @fs_userns is the user
+ * namespace of a cell.
+ */
+static inline bool kuid_storable(const struct user_namespace *fs_userns, kuid_t kuid)
+{
+	return likely(!cell_id_in_window(__kuid_val(kuid))) ||
+	       userns_is_cell(fs_userns);
+}
+
+/**
+ * kgid_storable - may a filesystem store a kgid?
+ * @fs_userns: the user namespace of the filesystem, sb->s_user_ns
+ * @kgid:      the kgid, after the idmapping of the mount has been applied
+ *
+ * See kuid_storable().
+ *
+ * Return: true if @kgid is outside of the window, or @fs_userns is the user
+ * namespace of a cell.
+ */
+static inline bool kgid_storable(const struct user_namespace *fs_userns, kgid_t kgid)
+{
+	return likely(!cell_id_in_window(__kgid_val(kgid))) ||
+	       userns_is_cell(fs_userns);
+}
+
 #endif /* _LINUX_CELL_IDS_H */
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index b5e0772aa190..dfe35b570317 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <linux/cell_ids.h>
 
 struct mnt_idmap;
 struct user_namespace;
@@ -149,6 +150,8 @@ kgid_t from_vfsgid(const struct mnt_idmap *idmap,
 static inline bool kuid_has_fsmapping(struct user_namespace *fs_userns,
 				      kuid_t kuid)
 {
+	if (!kuid_storable(fs_userns, kuid))
+		return false;
 	return kuid_has_mapping(fs_userns, kuid);
 }
 
@@ -164,6 +167,8 @@ static inline bool kuid_has_fsmapping(struct user_namespace *fs_userns,
 static inline bool kgid_has_fsmapping(struct user_namespace *fs_userns,
 				      kgid_t kgid)
 {
+	if (!kgid_storable(fs_userns, kgid))
+		return false;
 	return kgid_has_mapping(fs_userns, kgid);
 }
 
@@ -183,7 +188,9 @@ static inline bool vfsuid_has_fsmapping(const struct mnt_idmap *idmap,
 					struct user_namespace *fs_userns,
 					vfsuid_t vfsuid)
 {
-	return uid_valid(from_vfsuid(idmap, fs_userns, vfsuid));
+	kuid_t kuid = from_vfsuid(idmap, fs_userns, vfsuid);
+
+	return uid_valid(kuid) && kuid_storable(fs_userns, kuid);
 }
 
 static inline bool vfsuid_has_mapping(struct user_namespace *userns,
@@ -221,7 +228,9 @@ static inline bool vfsgid_has_fsmapping(const struct mnt_idmap *idmap,
 					struct user_namespace *fs_userns,
 					vfsgid_t vfsgid)
 {
-	return gid_valid(from_vfsgid(idmap, fs_userns, vfsgid));
+	kgid_t kgid = from_vfsgid(idmap, fs_userns, vfsgid);
+
+	return gid_valid(kgid) && kgid_storable(fs_userns, kgid);
 }
 
 static inline bool vfsgid_has_mapping(struct user_namespace *userns,

-- 
2.55.0

