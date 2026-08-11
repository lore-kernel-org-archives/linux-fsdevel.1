Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318D13B5B3;
	Tue, 11 Aug 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407390; cv=none; b=LfBy3RrVNoo3DQYOMclScrVkOEy7mM5fUqtnpR/kCJ2UQLfKHDnCqXSEHKuF03AEbsvLs0UDPmpSEFdE08hbl7tb1zvmIUWhpmemYeqjXiDjqAG43sRAh08WoW1P+kiQgsq7iKiQNckQ2SQxCFBZXudYUU2cU3EMbtgeP+S5T0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407390; c=relaxed/simple;
	bh=8NglSblnzUZZ6PuixG1N/FsAlVOLJAw6hzBUL47J+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWlPZtqkuYderDHqDx16gkXmUhLXN3cqc2IxYFBQLU1pXMLlnr0qK4LaEFdf/hTlKYJ20eB9BrU1gzzoNMBxXl+qGuzW+FevB/Uj+WPul51xPp4kNqguPY/XhIS2OxKX03mfZmPfEiK4Rs90Pr74TJGWbldwIeYJoKSfHyygQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyQnA5Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyQnA5Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC91F000E9;
	Tue, 11 Aug 2026 00:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407386;
	bh=8m5+gmXmE7S/zEc/dPZwpU+WcrnnCAAWirZENDQg6lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyQnA5Rwxkz4BCY8E8KHQyBid2g6x8EhCah/eiJZ/ssE02Tdc5S+7DA5Ei/PHjmVa
	 y2R3ShJTUSZ+iK1WS35P+gYBvEwSscDPdWbpHC1+D5DwDNxodjA0Xjs328+Siuh1JH
	 jjS3RcWoK3jTSZfxW0VmAKlkhk83rKDtE6ucqDEQ0DrNwyurAv/SISr19EYx2dS4a/
	 Z//AuQXyJE9mKkoqxVBP5ORBl9eZ/QlBjfBapWvvi3vwZPrngLv/36qSr+qpeJOEPd
	 o4tNabV5577pobbALBLAKv9dR+z5bOikaPBuSpY1rVrQFsBDCFzetI7l55G++hhduQ
	 w/bktBjkPWjMg==
Date: Mon, 10 Aug 2026 17:16:26 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: codemender-patching+linux@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
Message-ID: <202608101713.34DEA00E9D@keescook>
References: <20260810204118.1981755-1-morbo@google.com>
 <20260810204118.1981755-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810204118.1981755-3-morbo@google.com>

On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> +static void fdtable_test_alloc(struct kunit *test)
> +{
> +	struct fdtable *fdt;
> +	unsigned int slots = 64;
> +
> +	fdt = alloc_fdtable(slots);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> +
> +	/* Check that max_fds is set correctly and is >= slots */
> +	KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> +
> +	/* Check that fd is allocated */
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);

Nice to add these tests! Can you add one for each of the conditionals
in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-up
logic, etc)?

-Kees

-- 
Kees Cook
