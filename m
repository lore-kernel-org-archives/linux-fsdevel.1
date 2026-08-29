Received: from sxplwbeout04-03.prod.sxb1.secureserver.net (sxplwbeout04-03.prod.sxb1.secureserver.net [188.121.53.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEC4C6D
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787972221; cv=none; b=k2EIlZ/f5LRxk1rJ95QZQvfSoTQOCvxZgiuc1Rz3KqZSfmbvnFaEgbFWTgsozV1MKUgR8Qh8cdvF8VBp6v32TnllXUC1vTgVjA8Sg+/hUedd1mtL0jGp/xsXe2uNFpzFdpzLEN4A26epVHHLeeEeYwBQ/yVqPpk0InXJAJZglw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787972221; c=relaxed/simple;
	bh=mhdIRR6k68qlzdmDl8280LNTmbxnDpRap1CM9Wm8PoU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qelcn1f05r/XWEwlMAoV/xQbdnec/+0qOTf8DVPVfXBt9GkfjA3BloWqPPrb//DlRymKn/U8TqnUkBpYMyC4uY3zOQjTrKbLjdQ/HDjCI567c9s724XqAs8eFjh9n1eU45SCxI94Ahq3PXRKPzpTqZMhuKkyiLnRVWjNEiVoAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b=Qs+eO8O8; dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b=gXomkFUY; arc=none smtp.client-ip=188.121.53.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b="Qs+eO8O8";
	dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b="gXomkFUY"
X-MW-NODE: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1787971714;
	bh=7gAS2hG4XtErizg+CY5/rKZ2rLTIWEVOdaY6zNQYSYI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Qs+eO8O86pSdNt2dO4jcUIStQd3qNZTzKJh78BANwRHamLUSTaVD8B3TDLO6zJACZ
	 9xdcdTirjm7EXZwDC9g6VxIjiKeby2FqfhKG8an8oIFhv5EtLsZzdOTWoC5kg9uArv
	 rtkCe7JxTExKLzkDAPW+ZpYsQD8DHpGklsq4l6WElVMXAJoHlqq63fviOOdwfCo30x
	 +RWHUPRFeRRg14oScCDL754EPEvIKOTwZtZjU67Oj1XkdIixMo1xhNQ812f5zFrVRr
	 wxQk5XAehzzTIRetUkQf9V8mkcXWkM+Hx/mpCbNGr8QbOPDBOiZ7rRUPozqTku5pFz
	 Ks/w3UN8hO/XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1787971714;
	bh=7gAS2hG4XtErizg+CY5/rKZ2rLTIWEVOdaY6zNQYSYI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=gXomkFUYT8pOKm1uHD+CTbFXeVRkpd7AvgcsD6maFqjGhA4navu4KmN4brvHTMM4r
	 bggv2EdnDwADOYK+darLG/+hCXkeSwZzf7U5hi02B+EfxFMgwp9mPMSCAFfe+iqRcy
	 VS7ftd/iXDdvXY/VPRaBxzKMeslFn7sxck7rqSb2cJmt26o398k3JP7lCPBys8BIBJ
	 hxZNU41gGQ0AwUFHrgXNxKN90LIu7YObg/e/D4CzOmvMWWAQRiPa2e2cUpIw/Mkp2B
	 41lQhjVlV3dTgDgiO+7If5TvCEAN1wn+hUf7iJ3GXaHIR49i+q2qJjz8waPdiqC/tg
	 e/rDY4u1u7TtA==
Feedback-ID: f135fff593111c7f8cc914cc4ee2c2dc:squashfs.org.uk:ssnet
X-CMAE-Analysis: v=2.4 cv=U6Yr5eru c=1 sm=1 tr=0 ts=6a924881
 a=dFffxkGDbYo3ckkjzRcKYg==:117 a=dFffxkGDbYo3ckkjzRcKYg==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=Z4Rwk6OoAAAA:8 a=X2Z9Lo9z9L_cmQlZelsA:9 a=QEXdDO2ut3YA:10
 a=EebzJV9D4rpJJoWO5PQE:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=HkZW87K1Qel5hWWM3VKY:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID: 097Px7bQNGbLl
Date: Sat, 29 Aug 2026 03:48:31 +0100 (BST)
From: Phillip Lougher <phillip@squashfs.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <918464087.420455.1787971711604@eu1.myprofessionalmail.com>
In-Reply-To: <20260828163727.748343f2c87610ac6cd89dfb@linux-foundation.org>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
 <20260828163727.748343f2c87610ac6cd89dfb@linux-foundation.org>
Subject: Re: [PATCH 0/2] squashfs: harden fragment index table sizing
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
X-Mailer: Open-Xchange Mailer v8.51.153
X-Originating-Port: 45850
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfEURHaxsMIfEPmSi1aWDCS1or2G6sSySBJbjP4t9NfuVYJWo8+3Fv6hxewfCeHwcKd6xxEryGMa4/Ddb7ot6sr6dY6ws14W3qZf8Hg37NMZDw+JPSfYG
 L6ClYqpuHOACmbyjQiaUEThx6YxaREs9TL6DotZE3t6OYeP5xJ63B6FCpwj8+sNyDqimrGNdoo6iazES2rUlQn8dggJlMSMRMKMmriPjUmIKIhrlrzoMznmZ
 s+kY9wY8mAM8yea2nj2poxtlVR6KQvcyC1v5SCTIEZGvTtKn7Ev8XnYq7C0eWxH85KBOzHuSE6pPMYrbifaBo0DBEUA3n2J17mPBsCgu2f8OzMKuIPURQp7g
 G6wvQBGC


> On 29/08/2026 00:37 BST Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>  
> Sashiko review of this series claims to have found a whole bunch of
> similar issues which you may choose to address:
> 
> 	https://sashiko.dev/#/patchset/20260822143328.68867-1-kmehltretter@gmail.com
> 
> I don't know how useful this report will be - the first part seems
> wrong in lots of ways, as if Sashiko was using an ancient copy of the
> code.  But the things it claims aren't there have been present since
> 2018.
> 

I have been receiving a lot of AI generated issues similar to these on the
Squashfs-tools code and the Squashfs kernel code over the last month.

I have not been idle and ignoring them, and I have been spent the last
couple of weeks fixing them full-time in the Squashfs-tools code, and
the kernel code.

In the Squashfs-tools code I have reviewed about 20,000 lines of code so
far, and this has generated over 50 commits.  These commits I have
committed to the Squashfs-tools git-hub repository here

https://github.com/plougher/squashfs-tools

I am also most of the way through reviewing the Squashfs kernel code, it
is about 70% complete.  So far it has generated 12 patches, and there
will be more.  Obviously the kernel patches are queued up for a posting
next week.

So I am not asleep at the wheel here, I know about them and I am
addressing them.

Phillip
