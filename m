Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4744E04A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325010; cv=none; b=F1WRmFa5OuIJxfT4JorDJN+ITZJGva87SXkISbbSanqfsKqbNpVJJEncLmwi+mIIXYXCuLxqB9+o7zG21mkSmm7w7vw84DWRAB1fy8pZ2k3Aq12oxEyPQMRj/aHq3SG+ZhhrnA48hnVREV8bISlhMw3P0EHFDWpKCBDqdks+oSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325010; c=relaxed/simple;
	bh=Q+SDxKo/1YXK54KyxmvFyQaZIP1IokMnny7yeQjijsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDTsBXqsJahUzF+5qrZL0hJJ+qJB3nOIMPeOtVaLXfoS9UpMUUygq8G+oivmp/f16e/ni8dRM1boYk5A92e1ukz/+oVpkGlIaSyIKkN0+9X7svzTv123xhYvIjGsBMIXwwfXDzdplips+BEufI3j/jmcPPCYfSLTsUwLGFcqEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z41R4BcH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z41R4BcH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YPFdHuHtPzq7XqlKvTirwdf3XVvdLwJa1V+LvDfE3i4=; b=Z41R4BcHFhH0k7+hPSHxRBU1yc
	6U7VMtJKG5gAJVLN3nqtkCDBxP8loCp8MSHuxPLC22cNp9V/mW7kgoZXwjLQuvbKd/8pvNuCDy3E/
	APEceEUEk9kmeyx9fidTYZ5KrhO2yFDAMR4pIaSP0B8Pj7ZwkgsbXvGkDd51GLaWTj37b1rYVq5NC
	LHloxxt5riE8K+f5iZymfko8IWhgaDSiaRxiLu6THdm4Oyzk5iJhtWPpowuirMA9tF1RYi+fvd5te
	y4/CPLdu8P578gSvZpTT1y4Ez5bTp9si6B1bmhgN02i4HoOZ6wK7K9yyQDS26h5SKzPD7TpHu73SX
	uuwN0nCg==;
Received: from 85-127-110-197.dsl.dynamic.surfer.at ([85.127.110.197] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2ac-00000007kTX-49y9;
	Wed, 29 Jul 2026 11:36:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Krzysztof=20B=C5=82aszkowski?= <kb@sysmikro.com.pl>,
	linux-fsdevel@vger.kernel.org
Subject: RFC: remove the freevxfs driver
Date: Wed, 29 Jul 2026 13:36:39 +0200
Message-ID: <20260729113643.2255419-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I've recently been getting a lot of AI fixes for "security" bugs on
untrusted freevxfs file systems.  This driver had one known user in
the last 15 or so years, and I can't really spend the time on
dealing with all these automated report.

So I think the time has come and we should probably deleted it.
Unless Krzysztof as the only recent user and contributor wants to
take over, in which case I'd be happy to hand over the maintainership.
