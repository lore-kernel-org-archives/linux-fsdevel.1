Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E4377010
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774208638; cv=none; b=o+e8btyddMyiQznKaSu1GNcGouB2oFyiZBlVsJlgXbjc977ZQfUBf+JuG0zSrbayBwY3KPE+v2hwTlez2y86/ntWut7eLIU6sOisBjCMW9amN2OZwc9cI8cejv6DZ4cdqEYVPGE00r+BoXKEEEx11/JbKrQHZuenIgoeWdFHdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774208638; c=relaxed/simple;
	bh=IDv6lx1Ta4PMrBvbfMakPoZqSKYkLZPkih8ufQlZiiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=u3BxBoFZ/Z0DmIqZjEHCktJmYkJX6EsWlc1rqoWMnk+yxWBEWahc/u+MCxutt1Of+1IRCk9mmbnH1xjhIBhFDOhVGsS1fZ43FFMrCsWV7WoSGsZHAv5Uq6c5xujBDHXF3EOkbgMIbKasq88cm2shbXJNIM62hDqLD011Zf1h7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QuvqVe/P; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QuvqVe/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1774208636; bh=quVbbkHKpp5ZGnxnru2x/5vYGBdSIgBPbh1s2Lh97YQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QuvqVe/PxhAxQxn1vY7ieT+loh57lER/L6RcvDag2fKk5SMj0SsP/GC0cF9YId0qfhFFlI4Ps3ARd43J9M0aksHPWni7P2ynR0cKqF2qgmnmWOuoBcONj4N6oR6ciOHrGb9yG72Nu19RmYZyYZLCuK+Xg3JuF3KrxmtCRIIBkTx97o8MujQu796MuBgce5BbCz672JQsfV3Ny0Qnv6VPXsLPNYOmspYWMaw6N4YDuA+Ah08P6JnouIzr3zoGdMglcfHAe3d9enUyBeizOkyfEHY5usvOt+Hd8xvabY//dl6vbxdNDeNonv01a2Jv9PBPN2Idvu21ZBiDcz1QPvwRJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1774208636; bh=+bdpqcvdPMSlQg3izeUIVgxiDBexlUDhkYABKSYW+hE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IflfkBEXHvXSVGXQIWyr+G1EChxsk9JLD67VcFZx+8u3Y1L6XfS79GNWy2MA+MTeVtTPtl8Rif8kiRRdKYNPAIAvuOZC+pIMHatjamG8eyDs7KTg54g9VeQ9qZ0GyCAwTuTv8xhifpqalDEHE93g3yis9MK9xQbDADbeREwxU4C0knGj6eaZpVC+B8BekH98LQXDKyq+8jiy7GhTeIUR/dxup5KX6x4oYPlOIhFP80eNWphXTASsWx4alRSGw72thANpLuZy2hPAb/UF8ToVRLE0/eGmZfBPqwV9v0PfQlQ6Gx4mDLwiArJTLrm01/NMsqybuQptrkHVxqurD+8tXg==
X-YMail-OSG: TYhOdaIVM1mzMs2NfJDujBCerfxoWUPwJ4wyk0iwCcX91zu.5OxqtTiJHb6j5Qb
 c5jELhdwpxZduOHFAp33EecgydlVyVXHhvk6RhKEu19XNauNwN0KK55MHVPbgzSIczqetnX_0Mi3
 2E0Z3VbuKQ8NhHdm0kCmPoVCEnKRemn1zN5ksN5mik3QTJuXroqiIUrXVUGXCw.uzz4lSKSQX6_a
 Ord5eBjZKKv9fI.QROL8o4hxtIcg7Y7.Q2mUtGV0Qm.it1AlAeAhaJR4wAouexhEUndSq3dGTAUx
 Nq1tilAb6zkYRKvypX7lCcT18fByB8J5NGrrhzykNgueHfbUTkPKYrBB7K15m.ivQn2s_8PwMkPG
 X8gzCT9GdnXCV9ckKRefKibNvTpwu5vc4CB58zSseMznJc_ktkyFUdS.7E5z5E2AAnVZN3377GPm
 eEnmGRYwbwrbdsEhtmH_bo0zCUqKSgsq1iRo5bL7bOS1ZL6RPUtWSk8RHbc7NXui8ViX6wQNEEcZ
 cLpz9Uh4ser2ru8IUv17HbO8lc4j3ZK7h15jg36sjGnivMStvRoqFhiA9kiDxdDRiRoOM.DtRNQb
 9wu0FPliHbbJwQhkoG05S7BRyVUC6oOHtXwH6JziXvH7Sntj0M8TNbGDUPEeUMtCrZT_2yxgMmWk
 2RlIgUtxWx.obzUeR_WShr9tfmWbd217HcR4HZz09.8zNUzk0q5xW1CmKKt7odJHqDrjpqyY0DE8
 EzsXgMElTke8VMcflhR_1yXWgMILm.0pxeMN3zxZSDgcvajfUfKdwQ6tbzZ8ZbJiDfypxf6smtY_
 4IqUJsa2eOEM1B4v4Fbyig6RBNaqgas2_KTik0Hmy2tVzjn2ATSqNL.e971IswxOqCOLcrvL0h9W
 W2PmyPm365JQkPqapHfCu_BKtmvP9Xavx3BcYLUphQ.qbEw0R0vd4XkNWnzXQ8SBRtKxE7tauRfO
 54BUzgh3cXDe9ziXzfaHBJ5HH9a6KHlax6RZ6PmpFrkBrb.EWCY7cuDqIqsuhoXBd72IFMS53acC
 onZJx_bgUJ9c87.cp0ae_Ni7zxAt_6_c5ScmfVbD9f866SJTxdeElxf4m28xRG9_uzoyi9sIWvWU
 hsmglMmNcetDFQhdjd7jG.jA8fYIIagCDOV9dOMPG5xHF79oFs1ya4w.0sDdsjNf1cVx.WTMPC8U
 r1s0R_XwrlG7SlwUhovWe.MLLf1AIBWDi_h.ZWsNMICkem.M1rrYSNsKW8nckOPuMskUOvRYVvqI
 xNmF1geHrkuxB7CO.xAjgprSHnz42hgDFSGxmv0OMxkhyIXPCoV2gp435.eEq9E2SyqHIoVRH7Z7
 k51xNKVDzR9tOYvP7kA_laYl9QeaXzgU12njR6FOBgZS0yFzNIDfCfCZWxGbygQcIn85rZTeWp41
 PpJxW_r6KgXgX.aUSd8EvQQAQyL4Y.umlSVv9wbERq5QmYaoGT5WnkUBEacFSN808rQaRHOryR7E
 V0Dt1p1OBMHjuwz3h7_jAs2ZO7wwwMQCgoVGCMUjfKWizbTlR4XWlZZiHunnk8NR9eVFQ32DEGNy
 GxKMJFLzOiUh_ceOBeUm0n_NI0f_1OruKCrOkgD_ckkZezjTWazBDEr_z5BDlV5HzvHMgzrrV_Uu
 X1S_2vlLSTz720oBkcslDIrryE4y8uzZQeMaPn8O0UXHrGfoByg4Js5vYuBnRSalHegtHhvim.kL
 _dvDX94UWnYhegKcA8dZQauM.oWFf66.LWMgEXn4TLFENSR17z6kz8x0JdV96GgTm4_wmjBEI8zv
 1p2df_OgoKfm0mA_eAUtFCHbWrhV3yXJcspnEniQs.NKub3_I.1.RwhVbnuyaa_tpcF2Zxeb9C_6
 IEhXKqixA5ncXAO28likFPLM712AcltAm1c4.iC.FRpLTkx26VanahxQlHqnzy8jBLwvr1jH0EFP
 RjeMu.Wcff.LT.U1Bkeb8rWi1t_NZCqytuknSMK5hoLZSsuF0Wg9Q0b1kUvoa8A5luvJyiaTbbMs
 BYaV5ZTnk2lEEzRaIZJdoAcRoHwdY_g1LIYY4g8NRRovGaoMffVhT2S9ZS_X5.9d1KsKk1rmPaVZ
 ZZ_38MvUUfzbVyxZI.LOS8X8qGeM.daq4f8t.Drk4bSccNPwk.hXnIucd4NqezLAIB1pvcCoSYgo
 8Ec_0s6A9PbGMC1WkWEmOu7.NRtvS66jbZrxNai9XdM1qJqw4AAJIHZNsyhfhF719ljFUVPcfM_y
 o.xILmJHvNAZT65egRW61Ae6rF2nYjlqcTPHSbMYzsWyAoGDgWpuhkxQXwMgBLt1kGy6eMaNtkvS
 Z9tuDTNCBNxLbv.efZtkuxzLhNWKF23ARSw--
X-Sonic-MF: <abhishek_sts8@yahoo.com>
X-Sonic-ID: 6cf498d8-3ca1-4e87-acd3-718318dc6144
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sun, 22 Mar 2026 19:43:56 +0000
Received: by hermes--production-sg3-6959968fbd-n4v77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 78a103301ef87a298a8f046ee42232f7;
          Sun, 22 Mar 2026 19:03:25 +0000 (UTC)
From: Abhishek Kumar <abhishek_sts8@yahoo.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com,
	Abhishek Kumar <abhishek_sts8@yahoo.com>
Subject: [PATCH] mm: fix data race in __filemap_remove_folio / folio_mapping
Date: Mon, 23 Mar 2026 00:33:19 +0530
Message-ID: <20260322190319.85301-1-abhishek_sts8@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260322190319.85301-1-abhishek_sts8.ref@yahoo.com>

KCSAN reports a data race between page_cache_delete() and
folio_mapping():

  page_cache_delete() performs a plain store to folio->mapping:
    folio->mapping = NULL;

  folio_mapping() performs a plain load from folio->mapping:
    mapping = folio->mapping;

page_cache_delete() is called from the truncation path under the i_pages
xarray lock, while folio_mapping() is called from the reclaim path
(evict_folios -> folio_evictable -> folio_mapping) under only
rcu_read_lock() without the xarray lock.

The race is benign since the reclaim path tolerates stale values --
reading a stale non-NULL mapping simply results in a suboptimal eviction
decision.  However, the plain accesses risk store/load tearing and allow
the compiler to perform harmful optimizations (merging, elision, or
fission of the accesses).

Fix this by using WRITE_ONCE() in page_cache_delete() and READ_ONCE()
in folio_mapping() to prevent compiler misbehavior and silence the KCSAN
report.

Fixes: 2f52578f9c64 ("mm/util: Add folio_mapping() and folio_file_mapping()")
Reported-by: syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
Signed-off-by: Abhishek Kumar <abhishek_sts8@yahoo.com>
---
 mm/filemap.c | 2 +-
 mm/util.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 406cef06b684..bba669bd114f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -142,7 +142,7 @@ static void page_cache_delete(struct address_space *mapping,
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
 
-	folio->mapping = NULL;
+	WRITE_ONCE(folio->mapping, NULL);
 	/* Leave folio->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
 }
diff --git a/mm/util.c b/mm/util.c
index b05ab6f97e11..5ecb19ddf026 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -700,7 +700,7 @@ struct address_space *folio_mapping(const struct folio *folio)
 	if (unlikely(folio_test_swapcache(folio)))
 		return swap_address_space(folio->swap);
 
-	mapping = folio->mapping;
+	mapping = READ_ONCE(folio->mapping);
 	if ((unsigned long)mapping & FOLIO_MAPPING_FLAGS)
 		return NULL;
 
-- 
2.43.0

