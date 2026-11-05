Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892149;
	b=xZ8UAYkPxo3GJ/W+SQLR3eRH1DfefzC+djKjaBY9Zta2SdOHcxfnN8oobgkpA0tBOznv
	 Kemr9HgylF8QTUys8yMg+v6FtX2vx/oSpyxHFhzr4OYl5eqlV9AJMzVJbt0a0gqBtXmVU
	 PsdhkmGxElbGK4tpqz0nE2OckZIjGM6mY89uVWesMhT+ePCOl0fggwktk2lKQwRop3qZL
	 WpImvfy4qRcja0esTIxhfh6tpIGi3VILTVwi4itlnbpcwU+ZcatUvU7YBIA83Pf8IMyz0
	 vN0nfpIbz/F4X0PlB9mjejs1trOkNPY9zB1obdOglQquO5yyEc8YcRb9bZEF17UzyAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0lxvJ/76HcvhKa83JSTiM3ZrJ/dGz+3w7znSDhKLQQg=;
	b=Hitm3GAFWhXDaZolk4VKNnkee7HqelCyGjhTLaE1tZO37NIqaVtFBBJecUMzdYzCSGdM
	 w5CufLrJpBfAyDOkC1ZkUsxbSq/g/CeBmiB0IVs4S+G6mJ2csvmLeXVvIJ5kqGxpjNcVX
	 39pavRL8o2qJA+EOxxiRUOjWgihy/ADqzij76fsSERXhXBE+eAx2eC6CsfmFMg8jEgnbI
	 yR31wxLUiNDC751CsJ29PwKUAV+V6JXdeTwPTvLJvf6awP8JynLXFf1ZSZC4QXti2yOkq
	 vTnvvie6pJqxEpZuHSRr3qWmIDsrfVfqwg9U+rVEaYHx+VFbuIDjF+J5S/vHkF7D7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TI2YGzdi;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A88606D825
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A88606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TI2YGzdi
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c63449320so20341006d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892148; x=1794496948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lxvJ/76HcvhKa83JSTiM3ZrJ/dGz+3w7znSDhKLQQg=;
        b=TI2YGzdiR/VFX9D0aWiEo2MxUY1kqyU+HGVBlpLVvu7cdoPNbe13Ym48bWbjxjLnTg
         bgyEcb93WJJPpIVUNxRLzDFb095PtgzUNJkl3tNaBMHixAeP7JuvKbstgXa63etYlAL6
         Q96zGRuvvTzDWYVlHEJxKEIjxpj6St3idzM+7LBL1MzgTgibzX99n/DrqTuJ77r9NhGt
         Q+MRZcW2aaduMG9nitYvVdNBoxZUq/iWplY1ZREN4MGT+w2Rt3aXthxbeHadYLXYi01O
         K5dL/Fr4VSFEpq/0VNepMHBA0yhefF5/VCCgziGAIfqxLe0CmIvwNe2VT3iYeIw7S9ot
         12NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892148; x=1794496948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lxvJ/76HcvhKa83JSTiM3ZrJ/dGz+3w7znSDhKLQQg=;
        b=yp/qq21FZf5mbg7C5phAhqXGCUmtEiNuwJTDx93x7yl2fHVROKkC8Zkl+rBPs0kVqJ
         2JKuAlmtI109hXj5AxnXz2pmHWozOYemtKMxigzPgeT5xQBjwnOq5IxcRZpJrPHeEBKg
         sfupjnCAxrUyDC2/jKVmcj8Qkl0P/Xfq1LjD8Pz+I+oJw7EZsnbcp55T9mFCeu09wdiN
         T8nNpiLsafr4iKLMZhymyAyZfPd6+UOHuZx/Qt+wL9zSdocEwnZA8HvfneI7XB8rXDWM
         KPR/oJUzqWHwEwa+9WREUcHVgrRrVOLvULBedQKyi5RfPPcLgPJT1d//qjfiWIAsIfFc
         2JXw==
X-Gm-Message-State: APuU4Z+b7MMuYyLAtunyyO5ZSDLlSb/To08bI71+BuTz3oIxVBOUyDtY
	LQxQiFQvPVY/kw1hw9CHrjUW0y6xidnGJROZikNj4clmNMrrINy+Ovu68Y5QXnFsXBw=
X-Gm-Gg: AYBFou3gJLVvS1sHSVOhugY8M17IelDHpNTXLGskU/mYAaQVlOz1wtG7X72SGhhoYFZ
	52rTeCZqmGW4V50GJAyLmiDkidOcOYlLFha8pHrWU24gE1Hy6ZxBSUttK04i5jph/Z5HQa5W/au
	rLBTFWdZdJ2SP7mciFvmZYBVy15pT9zSMLbq5ikwhMqw5UPgnVpyaikULhSU5coXzbhvFpRVS8F
	5aOD0pOEU9J9ynlJ2kPykafOBDjz2SMJW+OP3ARetAMgXNEPKV9YxjNO29JoLh6n1zH6bdhKYvK
	TFNbzpQumQZtAfiSqllGxRK7P2tJeIZ4IvEuOkh0n6gaBw3OM9u3lbHgtfFok+d7uSd8j3rUExH
	SLA2d26Xhk0lFq0prJOOWRNaj68gF7Nc/NVl+mdAWJD3Npnmd78qr57SQ6T8lsJPJBzjtZ8IZui
	i33cFIFec+W51+zXF7Ljz0bBxVV122Ib8yfsiuHQn33m4PWRi5bha9SOCQ6FZ9QSxAEStfwNxqg
	PnFA4OPVJu0b145bwGRqBAzcJES889Cco+0iHc7jWPJ0QgjFzDxxvjT+kiMuWPMw1ctveCTaN8M
	8TqjMccFS6/kbwVVKDVjQcmebgCtaBk50QdmEd/K2/rGVA==
X-Received: by 2002:a05:6214:484:b0:91b:9330:26ed with SMTP id 6a1803df08f44-91ca4ae89edmr317307366d6.19.1793892147696;
        Thu, 05 Nov 2026 07:22:27 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfe9730sm49739886d6.17.2026.11.05.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:22:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:52 +0000
Subject: [PATCH RFC v3 60/90] keys: ignore an equal uid or gid across cells
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
Message-Id: <20261105-b4-cells-v3-60-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=2562;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Ay/7Whx+xkCdFP3sI7UgjbwpHquU+xt6eIcifsYqJRA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QItC6PokBhHDU92mKuhbIScpDNWyf3VgyF2JeLWS+0DySJGs21JQ3Ti9Dm5wF96SDAQt2jq3op6
 XkRY4NV+2oAQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

key_task_permission() grants the permissions of the owner to any
credential whose fsuid equals the uid of the key. Key serial numbers are
global. A cell with a single id runs with the kuid of the user who created
it. So a task of the cell can link the user keyring of that user into one
of its own keyrings and read the keys in it.

Record in each key the id of the cell that its uid and gid belong to.
Grant the owner and group permissions only to credentials of that cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/key.h        | 1 +
 security/keys/key.c        | 2 ++
 security/keys/permission.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 0bd77fcab4db..c291165e9096 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -215,6 +215,7 @@ struct key {
 	time64_t		last_used_at;	/* last time used for LRU keyring discard */
 	kuid_t			uid;
 	kgid_t			gid;
+	u64			cell_id;	/* the cell those ids are to be read in */
 	key_perm_t		perm;		/* access permissions */
 	unsigned short		quotalen;	/* length added to quota */
 	unsigned short		datalen;	/* payload data length
diff --git a/security/keys/key.c b/security/keys/key.c
index 0a6e741805d6..bbc594a0cb21 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/init.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
@@ -331,6 +332,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->datalen = type->def_datalen;
 	key->uid = uid;
 	key->gid = gid;
+	key->cell_id = cred_cell_id(cred);
 	key->perm = perm;
 	key->expiry = TIME64_MAX;
 	key->restrict_link = restrict_link;
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 4a61f804e80f..7b367c59cd3f 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/security.h>
 #include "internal.h"
 
@@ -50,6 +51,12 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 
 	key = key_ref_to_ptr(key_ref);
 
+	/* Across cells an equal uid, or gid, means nothing. */
+	if (key->cell_id != cred_cell_id(cred)) {
+		kperm = key->perm;
+		goto use_these_perms;
+	}
+
 	/* use the second 8-bits of permissions for keys the caller owns */
 	if (uid_eq(key->uid, cred->fsuid)) {
 		kperm = key->perm >> 16;

-- 
2.55.0

