Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBC33260B;
	Mon, 13 Jul 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936264; cv=none; b=e1mrceZmqxwurFUlgcFcE4S4AihiV9h12sGtW7IVc/3Hfw2ZBIx7+kNVPKp/tNwHtE4P5SiHQLQE5GOJyWUfCV+cA5NpN8VQ7r6RqAmfz3aJXMOpaiMzYu61u8Bdz1+m4OTlJ3orV+OmX6q69/ZCMa/xV/XHnxd4dtZN9v8wdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936264; c=relaxed/simple;
	bh=1x9KoWjkLhRgSKhmbVK21lW/aUw0YUdZaCz4BhVVpqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyQFZZzKCt7salTspC/xLOLZTLSqYb18hzoLsfpU0zt6aKCxVIcDHKvz3JsQhwBeSbI7pK9x8wmNHQJPE9piwUNTrqsCzcp95v4UHYa780VvngmzNkXKjljfpD1Cufizw18icFRluLRgMNECqWuITfYsO4Ox9S0C9fxrBeMboTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MM0hpNh9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MM0hpNh9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BcDhLtpVEGJrxEEBRpQRJOFY9ihKflRSJIXLQi8ZLYs=; b=MM0hpNh9JDCNatZfI4cNvtx69B
	+NTVIdK02FaJPpM4cfF8WfILaRACDr+7PFGKgIIUysvucRI6rxngAFmeDQN+dQwJLVnrqMsSlpdGd
	9s9iASgiu5bWH/qK6iR3xQGx7LYBp2JkF2TFP+Wmsc/KMAuIy4UKn8SzjNzMnvHr99Sm8+IizEets
	SxF9BKcvoq0JIvN19XzE98XLZSDHHR92d8Tzi5m3a1UePsmOXRSRNPu88uWwJHIbD1Q8O04+fv0ez
	amu+b+v3nCjldN+rB3LPlXGEaJ2xC/G4XwojJmJPDhloafJNgxWa03V85oXXo9Bfl9LY7J2dShUA1
	0wfuTCSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDJT-00000008n3y-2v7i;
	Mon, 13 Jul 2026 09:50:59 +0000
Date: Mon, 13 Jul 2026 02:50:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christoph Hellwig <hch@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Aleksa Sarai <aleksa@amutable.com>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <alS1A_lxSUXLpRq_@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
 <ak5rHOsvtMX1j7S3@pedro-suse>
 <ak8-lSfOy0oL78N9@infradead.org>
 <111142800.451666.1783594280454@kpc.webmail.kpnmail.nl>
 <20260709-skigebiet-fakten-galopp-29f4f1170f61@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-skigebiet-fakten-galopp-29f4f1170f61@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 09, 2026 at 04:21:01PM +0200, Christian Brauner wrote:
> Please just send a new version with the relevant issues addressed.
> The last comment clearly didn't even bother to figure out that nearly
> all LTSes return -EINVAL for the combination. 5.10 and 5.15 fail as well
> but are broken because apparently they didn't get the actual backport
> years ago. They die in December. And upstream doesn't care about
> Back-To-The-Future Frankenstein kernels.

We don't care in the code itself.  We absolutely do care aboout
discoverable APIs without pitfalls.
