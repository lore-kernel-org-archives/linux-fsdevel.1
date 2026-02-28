Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB74418DE;
	Sat, 28 Feb 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290250; cv=none; b=bbGnpXsoaee20p50Fy1LFT5F9E6iS5XFE5km0OoQUVPi6lFoglUIuzMLgCapGI4nTP9o0zjXL/dezj01Caqis10Z56M5vj/uE6zTY5nVKZSXptCEDt8rruioSBGb7ERwedpqcJWXSS9Zgp7gt6E0yypvXHjoQpEoJorlOM71LRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290250; c=relaxed/simple;
	bh=k1wJT17CWkEqrZTLDunFt7IhDFU2SBIAHFj70rVl8+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDZ57RY9uqF2PLs/XT6Xxzvoj3OCmyuxF0DfhHntZAcaWH3r7JCR8oyJuTnepePFbU2AvIAp8Co6RPYYBQ1wGDPTyp0Twgspefd1PEGQBIe0SBD4BhIQxBXsIEq+j37G03ZYrcbMzjOYYt0by1q+SXuy1dhKgQu1ybWfVigsZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Nd4+YwAY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Nd4+YwAY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XcHQCKRYEnli1Zwxe1X6fT4TlnETyiO2AI47u+YQGqQ=; b=Nd4+YwAYScoWduVFh+eFhP3I8q
	6BXmUNxp/x4pGLzqmpjVXbkGnqx2pU2rcyNu2zZJwbENSt0yGDrhurVcTovLKGrDbMb3YJP6zLFr3
	3DPmuX1jrFXATr2YODBYF9nQpRhlfhl7km+jpffIhw4id7d65BJ3L59Nfuhntu6+yHPswSMzYJxRh
	xbOOmtklYXbKQrsS39Tp3EwuCkqhxXfRiZKRCffem/gj+HHjHrDAPPhw4rgJXBUKXwh8ShmqHUMVQ
	UVjpcUJzZd9tAvXemJ4a5ji1AvMUTthM+HZEuRv1+ScgIAGumQLbFBPeeMZ8zyi2xC/RIICbs6vBG
	53dxuV3w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vwLeQ-0072B6-Tf; Sat, 28 Feb 2026 15:50:39 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  Bernd Schubert
 <bschubert@ddn.com>,  Bernd Schubert <bernd@bsbernd.com>,  "Darrick J.
 Wong" <djwong@kernel.org>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Kevin Chen <kchen@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 3/8] fuse: store index of the variable length
 argument
In-Reply-To: <CAJfpegtCNoNn-Ro04QO+k25_25v0_AyR=Po7hpnz1r4o=2Lnjg@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 27 Feb 2026 16:41:31 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-4-luis@igalia.com>
	<CAJfpegtCNoNn-Ro04QO+k25_25v0_AyR=Po7hpnz1r4o=2Lnjg@mail.gmail.com>
Date: Sat, 28 Feb 2026 14:50:38 +0000
Message-ID: <87o6l8yla9.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27 2026, Miklos Szeredi wrote:

> On Wed, 25 Feb 2026 at 12:25, Luis Henriques <luis@igalia.com> wrote:
>>
>> Operations that have a variable length argument assume that it will alwa=
ys
>> be the last argument on the list.  This patch allows this assumption to =
be
>> removed by keeping track of the index of variable length argument.
>
> Example please.

OK, I see this is probably no longer required.  In v2 the changes to
FUSE_CREATE (still without using compounds) would require the 1st outarg
to be of variable length.  v3 doesn't seem to require it any more and I
failed to see that.  So I guess this patch can be dropped.

Cheers,
--=20
Lu=C3=ADs
