Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF393471CF6;
	Thu,  6 Aug 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028430; cv=pass; b=H+fY+e4+XVAe7mgAb3ZurOlTHPKlOWRdXfJ5XbTbICzf9G1WFqfzK3rKKx0dlVFZRQ2GDPmihbZS6qWFVliKkSpz4HFkXRI0zUCqYsZYk2wCMwEwLxQqFddYBqBpZAH6wtjt7nRvjcp+8T9MTLnMixA68s2I3FzrxaiSpr7Isxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028430; c=relaxed/simple;
	bh=lPyoDCNeAjZWPFVhtXpKm8eFfwsnf6eQ2P5RI7WTssM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iO9g3tR3SV7uhN1L8auN//BMT7HFSeY1aNePeH1vnT8fOPaw00/LnqXRLpexAoUwO62GrJO7d9hwBrvN0vHci4Wq5hgYEMVjPyVu+tIpBiew3RYJX2y5sxFKJIflbNdzW4jprh66Wj4LlUxqNVxU/eoycptbtUC8LVgcraX6sgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=UBa2VCkY; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="UBa2VCkY"
ARC-Seal: i=1; a=rsa-sha256; t=1786028385; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GEHI7RLSiKkft1oq6jLFLXuR7jYxWuQCW9Fk1UeXxtTafYsmhuvD5L3XI3WUjq/AVCP4Pfsd/MC6fQr/JmP935HPelOUKF02oPEIgL1NpJheH8oU1fdHYIc/c7fKOjGx6EAfgH699FugH3Z9UbtYaF1maqTST9BFMYpV8OwSDjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786028385; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lPyoDCNeAjZWPFVhtXpKm8eFfwsnf6eQ2P5RI7WTssM=; 
	b=Fs/KnUqB33qkpZqnkpsDytSuvoG4XMdGOKGviDSeHoK7IADxvS66/gmAQwNtcOCvcNOwBeBSauu1iweCTPV8cY4VL6vJZTFkF2zbw4mASr2GVgdhhp2pNTUfxclLue0RxrMNJoxHXkqVtCoYpDScbJTFy3wIDQEcOfFgkJxcbDI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786028385;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lPyoDCNeAjZWPFVhtXpKm8eFfwsnf6eQ2P5RI7WTssM=;
	b=UBa2VCkYbGTdqyClUp4Mb2CLjYMaKeB093MGYXfcce7QIfeBvAo/4RICz+nIuuIh
	tyXZUJg6FuqN1YWGnqQVHp8AuUp/w2/tmY0QtOpW5u6foiYu8Uk1mt0GyfF6UroMHZh
	jB4aG5kQ9+Cd9E4q51Ot4KWvzzRXrgJd4hdg0v/Q=
Received: by mx.zoho.eu with SMTPS id 1786028382741726.2084533446523;
	Thu, 6 Aug 2026 16:59:42 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: ufs: adding read support for UFS2 extended attributes
Date: Thu,  6 Aug 2026 14:59:26 +0000
Message-ID: <20260806145930.173654-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Linux mounts UFS2 but ignores the per-inode extended attribute area
completely. There is no xattr code in fs/ufs at all, so the POSIX.1e
ACLs and MAC labels FreeBSD wrote are silently dropped on the floor.
The volumes I read are FreeBSD ones, so that metadata is invisible to
me today, and I would like to add read-only getxattr/listxattr for it.

The first question is whether you want that in fs/ufs at all. I would
rather hear no now than after posting a series.

If you do, I have the on-disk format already. I took it off an image
FreeBSD 15.1 wrote rather than off extattr.h, which turned out to
matter. The base length is roundup8(offsetof(struct extattr, ea_name)
+ ea_namelength), not roundup8(sizeof(struct extattr) + ea_namelength).
sizeof() is 8 because of ea_name[1], so the obvious reading puts every
short-named attribute eight bytes out of place. A single record can
also straddle both ui_extb blocks, so the area has to be parsed as one
linear buffer rather than block by block.

The other thing I would rather settle up front is the namespace
mapping. I am planning EXTATTR_NAMESPACE_USER -> user.*,
EXTATTR_NAMESPACE_SYSTEM -> trusted.*, contents passed through
untouched, and explicitly not translating system.posix1e.acl_access
into Linux POSIX ACLs. The encodings differ, and guessing at the
semantics does not belong in a first version.

RFC series after the merge window.

Thanks,
Ali
