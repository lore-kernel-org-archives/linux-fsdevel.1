Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509936AB50
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867420; cv=none; b=ExlCoLVphR+cEKGqBmz/9br8GJjVE1ATIC1IbCIviAcaPguxIGRzMA2KFMV22eR/2D1Yrgfu1Q9empgo1Xy7oJXrmATqJjzx5lLoQ6g5Zr2DFXUsStsiNnKEZEhj553D9qPLMsS2NdzwdQHCqiB8H+9w3ACdwvuPVNhs99rexY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867420; c=relaxed/simple;
	bh=zjzPna/RYv4VP3+BfFaZNO+PHykGratvOJiqNXcZQgo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pS5EvxM7w15Gl6ngeSyb0jVfKCtVzEdDeWuvo2qI+SzcYaHIMDuktCzy8BA6M+khQm6IPD+qKhh+qA5RkpzEOn21RNiB+1yiZKPi1LXFLrBNuDpc12H4QihYayTSlUMwu6jcPe3B5fCrpUUvtixgoixwkgd1IdOFIqTGX/QSZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=sIiBiXAS; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sIiBiXAS"
X-KPN-MessageId: d92cab20-230c-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d92cab20-230c-11f1-89dd-00505699b430;
	Wed, 18 Mar 2026 21:55:51 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d92b9984-230c-11f1-b5cf-0050569981f5;
	Wed, 18 Mar 2026 21:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=NGYADmYv5A3fRRYlfyQ1Rp8Zy4e9aSSJFxkoLBEuHpA=;
	b=sIiBiXASd1Pr2itcwBazCjNz1ARUQPrVpOCALqUAdb5yfh0lpwhGFHXM41Gj3oFSNxMiSjbOddpea
	 WBDxgrdqVs+FUOTOSAIiTH5qmzcD6/OGJa/IvkCgb3Kb1Br1h1GsSyNTOthREFFACqVGDiP5y8wXFP
	 hxB8+ytdjr5pwJ9NkDJkigm2cElG7t1YTx/08ws5iF8l2MsV38nsaLFAq4YgsfHT6gWYIJZwGJ8Nt+
	 iUccTPNnsj0S7DHlroPqMFQ8nzY006GNbwBhxBX5DICtmyen+7LpyzRb4+cjNWZmawUug/qOPFjLrw
	 V0wVsA9pgWd43ID2cXaOJhKIaVxHXrg==
X-KPN-MID: 33|v9OlZCgB/UM9CqW9WONOmrRvG6WHnL8t9XhHTfJjh/gSq55B99u1TxvHPV3GqMZ
 2twALWQx6fIP3IB5OMxsS/wvxKubhb2iqweSdQ08kvuU=
X-CMASSUN: 33|s+wjqflnJkldR3DAB65IdO4/NmhSYigpJ3rtZix9rD+vs4z/g4Wbpcc7PqDTQ5H
 9oYnrLBD/ch0/rs+G67YBnA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d91e66da-230c-11f1-b8d7-005056995d6c;
	Wed, 18 Mar 2026 21:55:51 +0100 (CET)
Date: Wed, 18 Mar 2026 21:55:51 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <184693927.2263750.1773867351437@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260317-ziffer-dahin-f1e651b5de70@brauner>
References: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
 <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>
 <20260317-ziffer-dahin-f1e651b5de70@brauner>
Subject: Re: VFS minor improvements policy
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


> > 
> > On Sat 14-03-26 14:24:23, Jori Koolstra wrote:
> > > I submitted a patch a few days ago about fixing the docstring of
> > > hash_name().  This is not a reminder of that patch, but today I came
> > > across something else in the VFS code, while trying to implement a
> > > mkdirat_fd syscall, that I thought might be slightly improved. We have
> > > this anonymous enum:
> > > 
> > >    enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> > > 
> > > but it is also used as an out parameter in filename_parentat() through
> > > int *type.  Now you have to look up what this int might hold, so I wonder
> > > should this struct not have an explicit type that filename_parentat()
> > > uses?
> > 
> > I guess this is a bit matter of personal preference. I personally would
> > prefer explicitely named enum in this case and use it where appropriate but
> 
> Me too and it should be cleaned up imho.
> 

I can send it in you like. I have also been working on trying to get re-open
masks work for O_PATH fds. It is easy for the OPENAT2_EMPTY_PATH case, but for
procfs magic links we might have to pass some state through nd_jump_link, so that
the nd is aware what the final open flag mask is. But I have to study the code a
bit more.

Best,
Jori.
