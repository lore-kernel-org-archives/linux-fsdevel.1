Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B724CEEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371376; cv=none; b=N5LH5PIc86QZrRTfKmZEQIoproDiGB9FgRaeOmWAt12uOg47oPLm/4e3CATRzgyfsy+aoKftsC9CXI7S2ZAqPSD4xprTQYGcbyC8P54k1jyIJpmf4mzLwyRjdtwFHE45l+OXdMRlwFZ9FsmZ2/c92OtbLQ0PxLwuxLhWAMIbtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371376; c=relaxed/simple;
	bh=3QwDk/HeTA8/TrfhxghZj8ZqBWpH7iaeCuMfJ7MIlnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V5sa5TXdecoCZOQPe5aKgtuCX/oWQtVRXOxahZz4L9pKzlfB8gmRY1d+YmqwLltVXIXghvSqQYNdnn8+/4iFLKJxhfHgffa6IVlKZTFwjTzB5stwSKcgdMSow8cYF5FliixytSiJLYnmtVUTMBglaEQromP5PVE5+S3HEHoKGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOkqfVhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOkqfVhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B57A1F000E9;
	Thu, 25 Jun 2026 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782371375;
	bh=/RyHSUG1l6yInKlHO8vL6Q+ePzu5eDGtAmKFe61uI50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IOkqfVhbPqs/r3NXLO62NTnfmNPLxtWHRQpxIW3ENaaxWKF3LvmrhRLGoBbtnMNAG
	 w0FgvmAqJyVrkYwzgtJVUQJb7zKbiPrWoal60Sq4OamLHy8ZIH///bzdOhulu3pkCS
	 Mw+9EH8SnpAZoaZDntcL0MGc8w1wBCCt/AtJw51xqmd4jvv8cOKPajErk571J34pCs
	 yvjqjF39mHidPELOvn3MELDgTMm4CDBrgIwH6Xeqoomso7lkKtYtwz53m06B8HV6DD
	 +EgnkSTA97f7TvM9cqtBRmkx0Cl3xEDcjWGYvE3aFylD5p5SEnuXuZ6uXIOdtsSQov
	 GRH4Da1q6/qBw==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>, 
 Jinjiang Tu <tujinjiang@huawei.com>, Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <20260623192850.1595958-1-willy@infradead.org>
References: <20260623192850.1595958-1-willy@infradead.org>
Subject: Re: [PATCH] fs: Free any excess xarray nodes in clear_inode()
Message-Id: <20260625-leber-waldrand-passierbar-11cc6a8087be@brauner>
Date: Thu, 25 Jun 2026 09:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3QwDk/HeTA8/TrfhxghZj8ZqBWpH7iaeCuMfJ7MIlnc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZXNEN8wr27RV+w//xbaz71RcylzZdWdWaffg35737X
 g55NRk5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMp0mX4Z7VoQpLhCtkVGxhW
 fl54LzjczfdUgb99UV3D1R0PH+Sy72P4K6PYE9bB6nkmc/sOiUtfPxzo/vDx8IxSLqcZUWfKVDe
 vYQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 23 Jun 2026 20:28:48 +0100, Matthew Wilcox (Oracle) wrote:
> fs: Free any excess xarray nodes in clear_inode()

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: Free any excess xarray nodes in clear_inode()
      https://git.kernel.org/vfs/vfs/c/aaecb408f8d3

