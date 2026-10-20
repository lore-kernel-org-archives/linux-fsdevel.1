Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500780;
	b=f0Jlxb4GLUQePJHEts8guLj8m6hh0r+hedJ+AZqHj1PhuGq0Nt/KSyavGPUY1Y2F363z
	 HQMimnachFwtkX+eOoOwDCYDLwlnJe9nhmUEaGjU94DSXFMVzzPQnNIG61bhDU7b0uOjm
	 0k0fOmICXcO6hgK3fakgWKFOwMBhAKyKaIo81z7hOB0TWpiV3k8iD085LPIXLpltWFnFJ
	 NQwQkZB2mmVcQtlZxsCGyA/ArVzhRF/zyRcaAPj0hwpX71b34N9x/VVnGzVXYcqTS1B1i
	 TCEvx1lNaWk8MUVIdcTLp4yoYxKA0mkGVAriPgbNbclGC8qehiqZg4cVZn9/Pz05T4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500780;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=rRcNYgYi/GwOg1rM/UtkaopIeg6nhLxQ78Ry4de+d01zVeuXt4ZM2zkDXc0Yo4bz9chv
	 k/M1Pi3spo4V6/57ty5PQQxtm4lrcR+0E6cdGF7WPtviqHyG1Fe5fxzZpAQRg2VhRyf6G
	 +6XY48G+2rNoXIRoleHe50MDMvVUKFvpfhGVs0tM2I9UGOeJNIwh1Qh/ptXsmfTljtvSw
	 38h7Bb29givcOMdMUnw+ejX/bvIMxHnD8cMYd7nym6L0xWE6L4lBhz43gEU6f+77zp171
	 d5yC84NhOKecnkIQJ6eZLaeINo5kZNoMsXmcaqEaejlkuGromI5d5svxaDlMpKUdh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLLDmEht;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sJcYLhdB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73B606F404
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB73B606F404
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLLDmEht;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sJcYLhdB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=cLLDmEhtx0mrq50fDaHA5xyChn5S8KGWVdHHbx7sLM+DxNqV+zxLx/R0lIEIjdH7D6xpRH
	1SWZUR/Q8YY6pnohrBnPJzaxpVZ/3xj5qFe9pQuyfG/3p0Xkz3YGTe3KYyBZduSBVlFpIp
	4PKSOgKF+wTMYsD+e0SQBDNGZeHXqUY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-GE6NLIsjM0qVBbzHIEKliw-1; Tue, 20 Oct 2026 12:52:43 +0000
X-MC-Unique: GE6NLIsjM0qVBbzHIEKliw-1
X-Mimecast-MFC-AGG-ID: GE6NLIsjM0qVBbzHIEKliw_1792500763
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1d43907c2so3612903a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500762; x=1793105562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=sJcYLhdBPlyCvITcjoMJCirtD3PPzZMPnNFxOe87vaVuhpHrIXWHIkuOu2iY/atHLh
         1JF7UuAGdokQTF27QVDwaogPAJj2p+i45CjQ82k92qVljM2CEAu4L1dtWpdcRnWg/nkw
         g5Fkgi0hcuM9hVOl68ideiHl0TGGwq+HjvnkrUPd9xztWqSqPwpQnDjxVrygB6s94SWm
         H6chIRaxCIEQ+keh44j1oAS7Bfjb2Ij3zS3txZkWltNNArc547Dqio+kmRJV/l6P3csv
         dbQjXRPRSp8Sp5p7+PkBB2gvF1Gn7wdPhCy0WReEFI3bOtSYOC3s6w5dvuTQJOBVNQgw
         JCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500763; x=1793105563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=VBqrWTrOJc/a2ghEVhfB8ZsFmP0aBYyuaMBxCI5ttz9KooxQH9x8Futxd36VArduFk
         8pKeNyVcoP7dyZutc2Y5qNOL8uSIDAfHft2aifgza9xFSTkiosyeG2XH6aDoUTpUEEy2
         WrP4bwpm9rzWeKH3SBZpWO59+Q9ey+f1H3MT0mWLCTBmaC1qRG/9bBq/RaMK18WKcYqr
         GMYasLrKQ9Bi62EDEBethtznhoSA2VTZaULR2Tqt3Amh8ttHiEp1HGcRVwxmLJh3I6qw
         h6fWpF/oblHN8wa5+fJpUyjWxSsaGAmJaDkn8BUTJXXJInaToFxQvRhOnCmJ4MqM2iYW
         lRgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5kYdkttpr4uycCC1daJqyo/au+Tpr9w2y3UfvgEayjUdeSp4k6bQuHjRrX2/Agi/qPX42au51dkF6B8dY@vger.kernel.org
X-Gm-Message-State: AFq9FYKJAkHXWPgtgX8YlRcUDo7XIcihKjn5Ba1gk1nwyjmCp0iOEBXN
	PDC8vEZr0DBTVxbSUJJgzl33Fc15bYbBOxEK5g32TYxHf//zvRR6HNjllSIlniYKZPqUyHY8TA3
	o6e0ymWisZbpPer/yYN64Q9gdwK7T6P/A0yYkmnkYC2jIPJ5qsagjKDHGzZVJvF4nTHa5uir5f1
	W/PA==
X-Gm-Gg: AYBFou0xz3UEF7WJXpl9z54upE1F9NDSZmXJC4p5SO5XpkeTrTUaLuawdQT+6neImlJ
	KMj8Ktrl1+t3jzyvz/wg6ttlWtst5ci9dMCe5ERi+YIPfFrbO3ULhcMxQnRz7S4um2GN/Hmn0yE
	TmkoDsWqzF/BespC1dGx1msyb2yKDfcMCdUKUykecfGzPUAAsh2wXTiQWtMyRSZpmpmoISnAcFl
	HsZvdfNFacx2jj/cl43cBNUc+Gs2T4lkEGVk5SEjSXHXIo/f3yXFvdCpGx0CZVpxzCt/Yf8w96Y
	cauBbELrxaL3ysLL8GMuz6TEtqEnBN1dQuw7+JCp6TsutiBnjvhVsahBZoeXAOlejhL4NeQEQFk
	YZerlx4EOQrwg2RIoJjPwSJs5HG/U4rlsvRC58Mnpk0buc6bvu+GLdZLLJ87dO5eaU1E55+3j/Q
	pTqMbPE0HO5/j+JZS4SrToRL5hkRNnsgZO8R8kRFBwTdX6x8RZkaRq7hTgB9zyXkNjfPOXb8th1
	Ks=
X-Received: by 2002:a05:6402:3206:b0:6b3:b648:3170 with SMTP id 4fb4d7f45d1cf-6b3b6483f02mr6091858a12.4.1792500762699;
        Tue, 20 Oct 2026 05:52:42 -0700 (PDT)
X-Received: by 2002:a05:6402:3206:b0:6b3:b648:3170 with SMTP id 4fb4d7f45d1cf-6b3b6483f02mr6091819a12.4.1792500761744;
        Tue, 20 Oct 2026 05:52:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:41 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Tue, 20 Oct 2026 12:52:33 +0000
Message-Id: <ad1e9d2c5ba4803f1c7dafc6687638b0489a7265.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792498351.git.amarkuze@redhat.com>
References: <cover.1792498351.git.amarkuze@redhat.com>
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

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

