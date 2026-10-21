Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605198;
	b=GpIxePvzU6t3v6KjOw3xpDeUYE2Kb3xDXLeEEEevriKNx+4MaNk5BpriH/JikKg/reWB
	 y9doVGuymwQAggQQyJgovyUV0jhnnSApiC/anq7rKH5E2n9TQJM6xDQVSk660IezdPrTZ
	 bWAZvOkUVYM48L64gwuLrSoF8JKLvimmCPre0B0biFlVIjhTNNHkpTB9GCgCu9/l/iSSQ
	 2sLadAcSVqFjdTqjQBH/nPOSSj7ACY+BezsGDyA85eKZaVToGwAjWSjSRiksG8sauTOY2
	 nYNptRBNv3fqxNn9+IjK/NulST7ZSFOJF9goiEOdZ/mPitKbrQ1iUlsZKFyZdsERX7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bvopn4Bqo5mm/LiFrwVnKxpY2c+FNJJoD3FpecADh3Q=;
	b=tPrtiFqyeTzmyJlhUaVsOcqAaWDoGwxljdOpKj0BLHDIwrHdMkZ1LsNwqhNlFsdGMk0M
	 u88OmfJpCruLbB+xNVfJyJrHp9y0ZK6EaidPGv+oeye3kOLuFr7tNQgkyFruhGqfAEuav
	 Nw7LAVC+D7k8sVw/MRjSc3Wzm1lxqOvCVUpBaeAXIlSL6QU+xy1Gia76RKS/fP5jx6lL+
	 TPje1qQKvene/hxRBPTewEjXunEF8xxdtNqbhKC2u6FNvGf5t1VNMm0gxxgRVWVa835a3
	 yh+pP8Xt07N9s7lYjrkasxirB42BIFTBEDQJJEU7aC87W6siqCyKiP84a60atCFzktg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KikB41Dn;
	arc=none smtp.remote-ip=74.125.230.196
Received: from mail-qk2-f4.google.com (mail-qk2-f4.google.com [74.125.230.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9F606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 17:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KikB41Dn
Received: by mail-qk2-f4.google.com with SMTP id af79cd13be357-93f38343369so62435085a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605197; x=1793209997; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvopn4Bqo5mm/LiFrwVnKxpY2c+FNJJoD3FpecADh3Q=;
        b=KikB41DncDcSaFMtrZ6wcc4ELt/RfWPaAhey8DUp+d5ic6Qetl6NB/JqFWlb76earI
         nDj1Lq3XmSNeRORBnCAak3AGcwDmmPHSoTsWHLoxjm60bnI7gvshiyGJ6BFfjARrSf52
         ri7QKTPfM4nBSflJjnS8wJJFi6GxjChacXWI0ho+9pJQwF1kQ5O0E4tcZt7z0J2/2Uid
         RY7U3VAwhx2OaF2JlJbMP3kFXvX3lGDpgGR2vYi6llvZklR9iQVAYtW2wvsxy5/xEiw/
         KEibdGdHBOYCODDoZEHNQFbqYSi22GZJqR0NZJRdNUsysq2vWbT6SBRrrtv/tL4jEruk
         VN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605197; x=1793209997;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvopn4Bqo5mm/LiFrwVnKxpY2c+FNJJoD3FpecADh3Q=;
        b=o5Es9ARS5llrKXAnR1+R7hT5N1GjNqv0F+2SiO8qr3+wSyuA8hvwoyq9FjTz+r7Vjp
         gvkZ0ypoQiQnYmZxa+l+sKaEssi0ASKu7DNUsvyPVqdawh8aiXtNfwDHrmb65szCkyw5
         ikkcXNCLATFDrP4EMuu+MJIU6Vj413E4WgMnM6uR5qD5xs34CgRaLBT3cElwm30IjOp9
         R+VzChIPh7N9ZaO8hBdHbytGbdMmtpgBPtlYfZBgI8+ke7O3y8pt/8R3YWceh1vG3K2h
         97SSb0dF25Vqm7tCiQMkn01UyokqCSA21244P4sv4z8kS/9uJaiDwigCXkHWLx4BJ7cg
         chag==
X-Gm-Message-State: AFq9FYIaw4cEAmZGF1+9QW3LRaVT17BkHam+o77/ppucozawLjG3UBOS
	vplO8nCrrZRyBNAkZE8fq59oasclRUkj6AJJBFn9gWpWtz5vfKIi7IZpIkVDtlOs
X-Gm-Gg: AYBFou3LvuoTEZSLAK/zn9QEkbEZq8r9luG2uTQqWMqRaO3uYHC8+2/D4lL1suES4On
	+lrT0MAvcS9Cgi271mmDJzmYpGP2YLBRV4dA5KJj9OCt2e9WcyMw9jw6HJeLAFmKRwADBwV6b17
	65OStdVvV5LBUAIzRhnJy0mDeofgKMN0dCPTETKSdA30V5sQtRGqTN2rQCvnlb+CkcQ2hYj/zUu
	dcmF+TcdNnh7NGMb/Q5yzjkHsBXn3Q0FBOa470GYALpOhIKlfHjTVfs/1/C3WkxEvFJL3JqH6g7
	1oJyxs87q+fTrChE6111cP8hWcpOVKzj84g7SZmWvifTLtw4x5Am1uB1+TkHKuiudC/GNvJxza4
	kX7KYKTgKT4x+AzCpPJO98x44dAAA9XrF3xcrVLJjBkOFerDCiQLn0xWkOgpFsot+vbTF8vEB9B
	OllF5pXM4F1yn5/TkpjvVZMUmWQhdPWAe3Tx748usjwDRDfhI99OVMvsQJesCoDL//IYSI44GzN
	lL62z17SZyBHY9lz8U0vrjXaDEkb6Z5w4w+VKrd+Dk2TnZ+aj1Fi22Rqz6VhW/4
X-Received: by 2002:a05:620a:8909:b0:93e:5016:e3a6 with SMTP id af79cd13be357-93f57f05f2cmr574659985a.26.1792605197349;
        Wed, 21 Oct 2026 10:53:17 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm305675385a.8.2026.10.21.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:53:16 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>
Subject: [PATCH 2/2] fs: reject U64_MAX cursors in listmount() and listns()
Date: Wed, 21 Oct 2026 13:51:51 -0400
Message-ID: <179260511193.411.8347258310589513211@gmail.com>
In-Reply-To: <179260511193.411.2849255769062027805@gmail.com>
References: <179260511193.411.2849255769062027805@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

listmount(2) and listns(2) treat their cursor as the last ID returned by
the previous invocation and look up the next entry at cursor + 1.  For
U64_MAX that addition wraps to zero, so the enumeration silently
restarts at the first visible entry instead of reporting that there are
no more entries.

listmount(LSMT_ROOT, param = U64_MAX) returned the same first mount ID
as param = 0, while param = U64_MAX - 1 returned no entries.  listns()
repeated the first page of namespace IDs for a U64_MAX cursor;
U64_MAX - 1 returned ENOENT.

U64_MAX can never be an ID returned by a previous call: mount IDs are
allocated above MNT_UNIQUE_ID_OFFSET and are strictly increasing, and
namespace IDs come from an increasing 64-bit counter.  Reject it as an
invalid cursor, like the existing check for reserved mount IDs, so that
the wrap cannot happen.

Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/all/20261020110732.959552-1-shawnq1@163.com/
Signed-off-by: fujo <hooyan2024@gmail.com>
---
 fs/namespace.c  | 9 +++++++--
 kernel/nstree.c | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c8aceeff6..6806745a3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6292,8 +6292,13 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	u64 last_mnt_id = kreq->param;
 	struct mnt_namespace *ns;
 
-	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
-	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
+	/*
+	 * The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1.  A
+	 * U64_MAX cursor is invalid as well: advancing it by one would wrap
+	 * around to zero and restart the enumeration.
+	 */
+	if (last_mnt_id != 0 &&
+	    (last_mnt_id <= MNT_UNIQUE_ID_OFFSET || last_mnt_id == U64_MAX))
 		return -EINVAL;
 
 	kls->last_mnt_id = last_mnt_id;
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 831f279d1..39978b56b 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -450,6 +450,9 @@ static int copy_ns_id_req(const struct ns_id_req __user *req,
 static inline int prepare_klistns(struct klistns *kls, struct ns_id_req *kreq,
 				  u64 __user *ns_ids, size_t nr_ns_ids)
 {
+	/* A U64_MAX cursor would wrap when advanced. */
+	if (kreq->ns_id == U64_MAX)
+		return -EINVAL;
 	kls->last_ns_id = kreq->ns_id;
 	kls->user_ns_id = kreq->user_ns_id;
 	kls->nr_ns_ids	= nr_ns_ids;
-- 
2.53.0

