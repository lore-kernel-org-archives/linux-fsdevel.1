Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E436654F;
	Mon,  3 Aug 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750298; cv=pass; b=GNac4GPR+VfwHBPWXDtHzmCkW2EGUXpe0njt4JrOWA6gImg6Oyhydyrm72czTEUWMRFF8XN37D+PgEuGQZl/6uPPM3MrsONzahHHFegjY2He4zt+BNFM2dIlep0Im9x+X2d4ZabSFMLzfwovoipwRUhuAfi+v8PT0+vyVVdrFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750298; c=relaxed/simple;
	bh=CKshH6xm9efxX5dNMMLveD+DE7tdaJpoGQR6VuYPA3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAViiNCnc7sF33X7K8h7FuIk7/uxR1a7bIT8QVBl6uHWoRNTjGHGIvsN6dYlZJ4vS+DclC0CuzYa6rqL2dKO2ufiYEk+wgUl3RfMMvKkOoQ1dGgOvWA3pDYg9nuSZm9VUsA8pzv9f75bjOB7bvS+ugYZVEQPxVwlHSXJ73rY1xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=I0JrWOtw; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="I0JrWOtw"
ARC-Seal: i=1; a=rsa-sha256; t=1785750266; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HBdGnpXjurNxVs/IZAr8rsQo4XBZCiv1wgvLPm53A+HtwZVl4YyW/rFay67bOc3dfKK5SFw5Eq3akN/M75b0rKUJAIUa5DjYW0VPXeaZQU/8l0GgfWcLwe/pxJcJw1qUERmb5kVTak8DGurpFXB8HVzbt26XROWZJFbvyFM2fcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785750266; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CKshH6xm9efxX5dNMMLveD+DE7tdaJpoGQR6VuYPA3s=; 
	b=Y0iDNOdReuXmpPGby+d/8GquQCnLx13mQ0YFgYABuy06vrF0ki9UHnIjSoq+LeMbsmaXMP5vzjUecJGfMdQ3+Mp0KHF4YOYGR7rWPwaqof/bTC9h3ILoNUK9RaUyzbQpBKLpt1VFEWFi0m9WJFpuX0jbGz0C3W2/gNMuuLEU+iE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785750265;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CKshH6xm9efxX5dNMMLveD+DE7tdaJpoGQR6VuYPA3s=;
	b=I0JrWOtwdacYiHXqH+S6Xj+TuZjx7YnxpDcp+WtRh/Kww4dNiaGsClLTJdafPfow
	P7m6kwLZSa1tShCc2nw5bhhaBNXIGN5B8vl10S1cG1lFij7+2aiutNSM0RXjKWjdwg6
	nzefPjysE6nDceiDKP6AMT5SggdmCNsavKXX31CI=
Received: by mx.zoho.eu with SMTPS id 17857502626134.746142058383612;
	Mon, 3 Aug 2026 11:44:22 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: jack@suse.cz
Cc: willy@infradead.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Date: Mon,  3 Aug 2026 09:44:10 +0000
Message-ID: <20260803094412.8059-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <opm7uuadw7ctvvo6uln22nb6id3pepcs4nohunq7tzeaciq3kc@kigwxsd3pcbo>
References: <am10yuQx5a3h2pXH@casper.infradead.org> <20260801073059.63651-1-ali@iusegentoo.com> <opm7uuadw7ctvvo6uln22nb6id3pepcs4nohunq7tzeaciq3kc@kigwxsd3pcbo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Mon, Aug 03, 2026 at 10:57:14AM +0200, Jan Kara wrote:
> I'm a bit curious: Are you using UFS driver in Linux? Or do you know of
> anybody using it?

Yes. I run FreeBSD on a second machine that I keep as a small server, and
its disks are UFS2. I mount those from my Linux box with the in-tree ufs
driver to read data off them, which on Linux is read-only for UFS2. So the
driver is not theoretical for me, it is how I reach my own data.

More generally that is what the driver is for: reading FreeBSD, NetBSD,
OpenBSD and Solaris disks from Linux. Anyone dual booting a BSD, migrating
data off one, or doing recovery or forensics on a BSD or Solaris volume
ends up here. It is a small user base but not an empty one, and it is the
only in-tree way to do it.

That is also why the mount path bugs bother me. The images I feed it are
real BSD volumes, sometimes left unclean after a crash, so an unusual but
legitimate on-disk layout should not panic the kernel. The fixes I have
been sending are all in that parse and mount path.

Thanks,
Ali
