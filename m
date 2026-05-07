Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB33B530D;
	Thu,  7 May 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146111; cv=none; b=Nfd0mzHF4UX9/LMPtpoJpcogQdbWYZ2FjctsAIN0c40qPb/JPWYAKYaHLj06WmNUCbhD903gHknd1fRmGaYx0y0dAyCPjvycg3enxKWhFfZN96NGymzhusi0AMbKAHPMeaW4zO/cO2Bm79n7w0ep3IGUFyt5Wkdd6yfd6glRe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146111; c=relaxed/simple;
	bh=178o+5XAJR9FcxxECLB4eJNmOcRXDFiwLbay6hI9XDs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZW/+cZmAqVB9hGfjlq5fxi+c1Y7UYWeQRxGuMrEJOZprT6K+eCxMgUqnltBeRQDKjmC2yIyAWjBb9yFtkRRMZ5IYb6wHigzIcTaIf7pEH44AAKTIwYyTvCqz+fgnVP/5s//fx4QlH7pOMF/zrnaC1m32JfuYIMnShxHZjgdggb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU/zMiTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU/zMiTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA53C2BCB2;
	Thu,  7 May 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778146111;
	bh=178o+5XAJR9FcxxECLB4eJNmOcRXDFiwLbay6hI9XDs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sU/zMiThEqUIGCXpYuDolUL9oExUHccG9nQDTkBFmCpdQWq2+vzizQAanCx4ETwzH
	 lrxi0tMkXwPlRVm+SIHWtE7EWtC5zo9mBALsrUNajbxpEguO+o0+DEWy625/2MebZF
	 n9rWyyHoM00mSE1OKle5eAy2qOaVw9CRbn4c6TO7qV0udyZOYZ1VbxbTXET9kU0U2Q
	 TD6c0AFT6bsLNnhQuhk/dObaRAgKK4h4HvUDfFGmZ+5r1GDm/C1c0RRNmkP+k1U0ks
	 O8BDn1LAIHG7Fvvp0yjJ9E9kMyIF8CGQlMvyPsFrqcEAXs8dUiXiHASPU7wlNtdDls
	 dZ/KADDtfTpPA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 11:28:29 +0200
Message-Id: <DICC6TIGNBZA.1ZW4SSME21HRF@kernel.org>
Subject: Re: [PATCH] sysfs: upgrade OOB write by buggy .show hook into
 WARNing
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
 <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>
In-Reply-To: <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>

(Cc: driver-core)

On Thu May 7, 2026 at 11:01 AM CEST, Alexey Dobriyan wrote:
> Buggy .show hook will get just 1 line of dmesg:
>
> 	fill_read_buffer: ext4_attr_show+0x0/0x600 returned bad count
>
> It may or may not oops later in some unrelated process.
>
> But buggy .show hook most likely is corrupting random memory past sysfs
> buffer therefore deserving more. WARN, make it more visible and let
> QA machines panic earlier.
>
> Also, delete useless cast -- "count" is >=3D0 at this point.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

NIT: This patch also cleans up the stale "fill_read_buffer:" prefix, and in=
stead
points out the actual caller, which could be mentioned in the commit messag=
e --
no need to resend for this though.
