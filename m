Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552165464D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724371; cv=none; b=R4SoF0HbRyLYJIvY2+n9tjRs6KEM5wfsGxlrvCerc8fp1raR3QsyeBoU8bnBSDvRMA1FkUO63lKbWr+sepBWPRnA2VMQ/xi8BpUBRpsdsOKjiUIaIr1hROKg04YXiQ9PCR9LtLoNDq22FYlLirnjoEZcsxlLhNJfnwSxPW+9+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724371; c=relaxed/simple;
	bh=396wCALaKaUmeci+Nx2ltbXlJ0czPV9IdBm9YXaLnao=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sYCs24eQgqamxYsRjIV+zozyNY/rt7OZhdr3X7S5oo5rU9O82bpgNUX6dOQeMiKseG4ahdYW0l1WykaGCFQdM0/vxapbFs+Ctli0lAgd0ReCHm+x2ODebTkhFPazVA5v6kDDPevGXDOef1M0xDMYb+3l1IIPAZR6ukkEBsnZ+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2VoxnGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2VoxnGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EEE1F00A3D;
	Wed, 22 Jul 2026 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724367;
	bh=MhkpW1Gq52/56zujLBT76pwpkNWNejrcxCa2NZbY49E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=o2VoxnGGSrUyfoqefH7mddUE7yiScb8AEOjPVXzTHWtDzCBOs3YurkUIweaDf0V7f
	 zRY3NY26+awln+bpGx1KMZTcE/ibLtF/MHiR89aUp2zgZK+u8z7A/9myLpJtJrzVgN
	 ocjqllcs83pdlPwWYT2dg00pDBbNJU1i7Mw52TYgSTBUr2AZCpNGo0aMiUlNoNVhkK
	 1ukHozN4I+IVmJx2UQQuJAgx5U0ivO5nPMg0zphGAZhZXgGolC+H5wPFdRa2HqYU/2
	 0+sMZJ21n6vPMPmdc3LTeqHULz4QR70Enp2wdqMoD1bFsUUBM3sMxHYlLJJ5BafORz
	 HSbuc5wobV4lQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/4] VFS: introduce d_alloc_trylock()
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701233128.3356519-4-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
 <20260701233128.3356519-4-neilb@ownmail.net>
Date: Wed, 22 Jul 2026 14:45:57 +0200
Message-Id: <20260722-geteert-wortreich-beilagen-3b769f2ff017@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=285; i=brauner@kernel.org;
 h=from:subject:message-id; bh=396wCALaKaUmeci+Nx2ltbXlJ0czPV9IdBm9YXaLnao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7O7K9GjlfTx/h7J7Vmy4YHT5rOOxRhwHsp8d+3DIY
 JNHLd/RjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYdDL8U9waLXqxcUaG9LHI
 oE/Rv3KZGWo7CraVWLRc8+6uu8TRw/BXyrY4M+FRrUh/b9Mf3ex7T3fdD81wrJbbeqc2pjZ+z3V
 WAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> + * The @name need not already have ->hash set.
> + *
> + * Returns: the dentry, whether found or allocated, or an error
> + *    %-ENOMEM, %-EWOULDBLOCK, and anything returned by ->d_hash().

lookup_noperm_common() returns -EACCESS from the name validation.t dentry *,

-- 

