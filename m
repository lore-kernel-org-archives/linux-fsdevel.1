Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E4346798
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489609; cv=none; b=gdiMz9T9HcrjSxULanYLfShB373TGmEwg164cNDcCyzsLB2UUFID4xEbxRG0ah3IqH0rIINfrSPa5CtvynQtBIeb/uUYc4QMnOuhl9Uj/9tiyMHVre7jItEd7a64DVKCxdnxaLe6Hh9V2ZDUDKsNFTqHiETO+UTQVw6aDD9H9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489609; c=relaxed/simple;
	bh=VtxlQljE/dbURKMyDKtZqF8rnZ80s0faLeSyS6cuhNg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=P98+xoy9fcRqRTjNGkd4dgVm27AK4w6TVplWEcHPl1k1+Ntof1pvEyUEc7mQurqvxmRmtPABsyM3mGZHrppFqG0RE4XR3TzYkO8BfSjwBAsYHbgpe5P/ETPsqRrJH6I+EZKDIq1r5pD0RbLs4URQUh4seTVf/ZcNCu02yFN3DeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=okgFCamt; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="okgFCamt"
X-KPN-MessageId: 03a942c7-8cc1-11f1-a5a1-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 03a942c7-8cc1-11f1-a5a1-005056994fde;
	Fri, 31 Jul 2026 11:20:04 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 03a7d55f-8cc1-11f1-b31a-0050569977a2;
	Fri, 31 Jul 2026 11:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Ugc34RckBiQoPbusxr7fafSabBbp6i4oTNEA9CY2mAU=;
	b=okgFCamtgKk6DYIEBDF1mvjAJn2iW/32smXLfJwhvM9vOTRjleB4QaGu2sKWRM+NR6oqUMWxNBPHl
	 3lLDxQH5WfhQM5QC9JrWCrBqx4fpyFiW5YjlN+jkuxUMrmYctAzorHx7UPyj1XDkbGANb8A3JejfiX
	 I6xbpDrZ2ex3Rrf9e4tYAheoEzDO0J2lxRgBxZE7mDsZwFWB5dNaA+1N0fhfCGQL8B/P1VyE7RHoOW
	 O/OCuy6GP7W9+rC3IL/L7TPp2+77ujMYNr7LvFRh2t1wqFjU+iKwzUOxaElbG16JoQ46aFub6u6Ja2
	 NKsCQEIB7Vb/eZF8YBBHrI30SsM2pzw==
X-KPN-MID: 33|e5K13WgcHm7Tb6l5ca7EeXRgfGjBAVQhU/n9AyIGbq7mtCjC1+DHVR/f6tEdLS0
 yWYO8xW2FgXTJSqvGeMIYpwU23hANkMFVnq51k5rYCa4=
X-CMASSUN: 33|8hUWDkRV6zIu0OaPXdRv7NFZqfCaXjPVIH6EvCJ+9u+khwc44DXXkivwJyPVXzd
 OqcQEvETjelUp55L8Cgb6gg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 039b66ed-8cc1-11f1-916a-005056995d6c;
	Fri, 31 Jul 2026 11:20:04 +0200 (CEST)
Date: Fri, 31 Jul 2026 11:20:04 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Message-ID: <1573100765.693247.1785489604226@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260731-work-lookup-fixes-v1-3-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
 <20260731-work-lookup-fixes-v1-3-2412b85cf65c@kernel.org>
Subject: Re: [PATCH 3/3] fs/namei.c: fix coding style in atomic_open() and
 lookup_open()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 31-07-2026 10:36 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> Commit 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on
> failure") indented a continuation line with spaces, left three
> declarations without a following blank line and used a trailing */ on the
> last line of a block comment.  Clean all of that up, no functional change.
> 
> Fixes: 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on failure")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 

I know checkpatch complains about this, but since namei.c has a bit of its own
style, I didn't pay too much attention to that. Do we adhere strictly to
checkpatch style in VFS? Anyhow, I'll add new lines after declarations in the
future :)

Thanks,
Jori.
