Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF23F2111
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039869; cv=none; b=uui5Ew4uzjAcHre0Jg89j7EFThp57GBFRgbRd6EKmuUD4qwV8h/3BmrGTpPW64IP0S0hZqv//LAJjesMoPJKv42b4zluoxROeLUfFCkCIYGN5YnHDSdfHEDg5J6BB+s7YoBra4lHCoD/5oKYW8h/+lhi3yFja2sBWtX0hauCKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039869; c=relaxed/simple;
	bh=gzSqeVm80YzKd2mafY2lnnpCMlNDisunLuiscryc1v8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TM7U0A6KPRYqtdraSZTM69bY7kljpPbTkX0FMcUoFDzJ5ntZqfXvEh3AgkjuOdifiPC1QrRFm9WstT+Op16pXRi/mMUI0lUCMBH69iubB2R9SEKyacTrX3PDzO+/EmyEYEignmkBkKULv8xqXiiWrIUr/nYE6U2PStT+PNzMQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=aUw8aL3m; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="aUw8aL3m"
X-KPN-MessageId: d0809321-2db6-11f1-bea6-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d0809321-2db6-11f1-bea6-005056992ed3;
	Wed, 01 Apr 2026 12:37:43 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d07a3198-2db6-11f1-b5d0-0050569981f5;
	Wed, 01 Apr 2026 12:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=DSdCJ/cn6ejLZPHQtq82/l7IQ7UXCt4ejQjI9DF4XB8=;
	b=aUw8aL3m3ewWa6jPPPybw7d/Q3rDHAIZkuRbeTN3JpOJlKlDPwm/v5vZ1CGBRkR7pLfRMh03Riq9z
	 q8EZCn97kiRaRTJs3OVb7BDoHTCLui76a3JY48JN3kmnV+z2I/gXWi6UxUJFYYg8JTx67svLCvvbf9
	 J2BaIZdxIpB9r6O9etyoq50++D3ONCSBqGqBUFsZ9Xy6ZCYNNN1g47lSwbBCXrmusUfOQHrkv6R013
	 9Vj1Zqvao86qsUVKs5onZntoq68dS+GT8ltO6twcayAHSQ2izxsThbU2pJbtvyUUHjnWfby51gFHkU
	 n3w//2ykAQL+mb1ZjkI44iZhmiPzVXw==
X-KPN-MID: 33|S3V5FPlNRkh8vhY7yarLhl4DuIGalRV68vbhIqsnstB2/gJnGgtdfFGF/UuWK+r
 2L1VqJrU/6KtZXXMYOi21nwd+BYKeU25MgVpxEfO/r8k=
X-CMASSUN: 33|f1KrT0mendhAIWL8AxHMdZqPBRS1k74qGZbutO+rn0YkSRFfELEPTglL9adFtWN
 Er4YJhitCEy/dignlHaxc1Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d074e9e5-2db6-11f1-b8d7-005056995d6c;
	Wed, 01 Apr 2026 12:37:42 +0200 (CEST)
Date: Wed, 1 Apr 2026 12:37:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <842453183.787323.1775039862978@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAOQ4uxj_sH3Owh2_UEHXGY81B3yoZzLF0DWZm9OPCPOiLrzL9A@mail.gmail.com>
References: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
 <CAOQ4uxj_sH3Owh2_UEHXGY81B3yoZzLF0DWZm9OPCPOiLrzL9A@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
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


> Op 01-04-2026 10:29 CEST schreef Amir Goldstein <amir73il@gmail.com>:
> 
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 58600cf234bc..e79ff97063e9 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -16,7 +16,7 @@ enum { MAX_NESTED_LINKS = 8 };
> >  /*
> >   * Type of the last component on LOOKUP_PARENT
> >   */
> > -enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> > +enum component_type {NORMAL, ROOT, DOT, DOTDOT};
> >
> 
> Nah, I don't think it is a good idea to poluate the global namespace
> with constant as generic as NORMAL, ROOT

Fair enough. I thought also maybe we can keep this purely internal to namei.c,
but it turns out there is one user that I missed in fs/smb/server/vfs.c, so that
one has to be converted still as well.

> 
> At the very least this needs a namespace prefix such as
> NDT_ (nameidata type)
> 

Maybe I would prefer COMPONENT_XXX.

> But then I don't think it is worth the churn to rename LAST_ to NDT_
> so I would drop the constants name change altogether.
> 

I mean if we are going to use a separate type for this might as well clean up
the semantics a bit. But I would be fine with keeping LAST_XXX as well.

> Thanks,
> Amir.

Thanks,
Jori.
