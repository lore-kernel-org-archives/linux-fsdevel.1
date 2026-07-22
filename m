Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE6149C6F;
	Wed, 22 Jul 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724721; cv=none; b=PgVTxE9e2evev8MfGP0kzfOfftDoxRm9qib7CiJZ6JtVa9brpSLYxtUgjXsNUUZ0EebLUolfTpMVui7oI18lg3kMCtoPQAvtfz3AbHLQzErWJmBUVJPmrHDuhRxBffLDr2fmB46FG9Y5Ubbi8b5dTx3iMD5xujQtU7A1+TQXb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724721; c=relaxed/simple;
	bh=DQIYlITP/tkXLuLIhS3vGH099c37up+g4gkxSl1ZIi4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=leWOVHPWFrz3wnILjh6Ted0ikZKWkdmiTJ1KzyVtcsy6P43QliF73ZWrUx4U+hVisMlE7JAZW+nhgVIH676aynnmbE4ro9aqnC+m1VLuVSItozwCzvcTD5R2ot11tGX7WHLqRF9B8fqQHcd6qU+KkeUc18i72PoHOiEkV3NcE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5V65y9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5V65y9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3279F1F00A3A;
	Wed, 22 Jul 2026 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724720;
	bh=yD7S28WEjjitKHYE3fBInmdRzOfhYRPfNj6J7TxImEE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=X5V65y9zxyDljLcu8mxZXoly4jQhMR9cnZVhX5GT+1aQICmVSGGoZxd/vph5lNOyM
	 jc3QYzOsg6S7L40jIZHBQfbz38S6acJuFarBV55oBDEy0SIeJo1lPhpVWBbMBhcska
	 ZE+0mLzRb2w/iOYySHd3WKG+H6QPPat66+wGKwHjW8EEITnGyPNz6msJO/vw/XxZjX
	 fRLmDQNuyRpBEIG3zW+aHNTTHowkQEHgs9Vi98gWcff41pvv3sFiv6Gzol/SlB+tlm
	 c0GbQoBxNVs1RekdTrjX60WcN7IfZ5+siuMXuuQfaI5IO2YxXQ1YNHvljvgB66rYcU
	 Jya2XqBbmrneQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Pedro Falcato <pfalcato@suse.de>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alS10NN_OduZEqvt@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
Date: Wed, 22 Jul 2026 14:51:54 +0200
Message-Id: <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=599; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DQIYlITP/tkXLuLIhS3vGH099c37up+g4gkxSl1ZIi4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7HmjYXZj09OD5UbB04s4pA67TZjbvanw1ubYGf4fZ
 N7d9fK831HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRX+8YGZ5PYnPj3Pi54861
 wBc33ape7n0sIlN/SzFm4u5rzVP4r4Yx/NOMry+5r7rqK5cpP0Mqz4an0cr6jzTZ0k90c7U7Gq9
 v4gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> No, we can't rely on something being backport to old enterprise/cloud
> kernel.  Doing so makes the interface unusable for actual applications.

It's backported to all LTS kernels for multiple years and this
nonsensical theory of using a software version with O_DIRECTORY |
O_CREAT on a pre-LTS kernel from years ago is just flimsy.

Even just the mere fact that I was able to just backport that bugfix
that started returning hard errors to all LTS kernels with absolutely
zero regression reports defeats that argument. We've done way more
invasive changes. This is a strawman really. 

