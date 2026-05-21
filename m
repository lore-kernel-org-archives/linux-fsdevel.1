Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97C35C180;
	Thu, 21 May 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385243; cv=none; b=LBaH9d1e+Ji6G8qcx8C/t1pCekp8cRzgXIG4Lf5HvaGJQKtxTNRMY1CCau6smWT0MGh1lS9qf/GA1GJpNfCeDT0rb5lOMwNQMtm92ZyavG7wBQ2C6Nta7HBY/hynNhDMpyiCqbtUlKl8Hc7Fx/Q9Llj5kYpSzTxgbjhfH93hZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385243; c=relaxed/simple;
	bh=K/tUIWESQhcEhW++IQJ159qa2RcZaWsRZzE5eHlQlTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfiXfEbMftVpLa35+O7RJq/eopNybQqqtNx8OQ/iR0tIgH0yRZi108YevftjtVZ/qTTdId6jcnTcDZo34pH1vEeoTTFCs906fntAS6u4C6yohpmekOjb0VvqryPAkbHF7Sd0JjBuCxbgFWTAr3O5I2JOfK/RerHJtfUag8u3goE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Ksdfi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Ksdfi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2401F000E9;
	Thu, 21 May 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779385242;
	bh=Iy0DBV5yr2IKROBFgZMGWxW810qG1onsLYgqt8IV0sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9Ksdfi8WgiYGmmJnReGAn/z4FypCKzCrtkNVSuZ4Jsw1j4CWKg09tMOAjtzfMk1u
	 MUxb4biwZz1w3Z7fdt0NFeCqUDUc/zj8498JqG2QTy/YB7GW/04fhaNuVfReDzqc7v
	 bClSOXbrouLTHIwahk+YWGupeIBoaxOzMH+VacpsVXsjZnYegWSmdEvUMjg1hx+kmN
	 ipPCwW96RM/QWL2DUssqBaAK1FrFr+fsYH61RWXPd/Fh1k5g7o4WaLyLEdyEAR7Bzu
	 8YvQXhgftU5s138dbJCOHnGIJMLBA+9VWsa2xi4m7ME64BibZB+7cuipiXC9XORIsa
	 lxF0r51SKKgEQ==
Date: Thu, 21 May 2026 07:40:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] writeback: use a per-sb counter to drain inode wb
 switches at umount
Message-ID: <ag9DmbVpBDRSXBxq@slm.duckdns.org>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
 <20260521095016.2791354-4-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521095016.2791354-4-libaokun@linux.alibaba.com>

On Thu, May 21, 2026 at 05:50:16PM +0800, Baokun Li wrote:
...
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/177910456953.488929.2169908940676707307.b4-review@b4
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
