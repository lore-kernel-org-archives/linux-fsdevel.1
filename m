Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050E32862F;
	Sat, 28 Feb 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289769; cv=none; b=X+AIhi0NAfe1lFtKwioJL9HiWIuNdrh+NL8GngGxOpmItPrwLscqEv3vzEYvNBXuu+HO4f7YumXbSFiuCWTd2mFxrN4oZiEaVZfnPRZMNOAidAaKqaL9789u+SsL+r4V4SWhlqFr5FDDSjnHK9kME7WhEC9PLigynn3mC6kreHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289769; c=relaxed/simple;
	bh=J0uBb9H9FfTOTa/6/cYwgPVL76Mog5qPD92xGKEv/G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AWPE2tqYL4SsAnyKc0zOiop8QjZvQE+Yiqc5+q6gslmjTaq7OFxh54if8Oa3sFeaNI52XdCm0gojWGdn/xhVh1v9tdX+SnNWmXJTRCMPlAFszzsRPOZoVK2Dm0JED5B6c7g96yosXXTcoxXLu2GknhCh1auvnN/03O1iucMan04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BfKnac5g; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BfKnac5g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mVyxZRFT8ZoYynTp0rLgZqZ23iPEK3rdkmZ1ZHncfmM=; b=BfKnac5gQt+ROidxs+1WWjLJCr
	zLoy+IQoa2EiJOjkzWYnIp+qIa5OLclKVldvm7s4suhNE6xbNbpIJvn/Ilq0HdbS1fYUoeKdUkGmy
	pWOM+ex1GnqoqZRPFuCNYWqB/6sR2worBfgSGxE43c9gb2fcyvGTib2ehZ/QBxQA+p9wg9PMI+Htq
	F4aiH3C301icVdJcT3LtYIneUpdz9i6p0+UaXQqCdCtyv2V+SD5inQnCHJHCRJAxBx8cJvM2JSidW
	BtBk5kgbZe9vBzsjX+FNj87bn5lRD41H3bC1BemijssHR2s5T2w0xN7fEKH2HQo7pLvU2sBL5QS6e
	pieVX2Hg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vwLWY-0071co-GX; Sat, 28 Feb 2026 15:42:30 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  Bernd Schubert
 <bschubert@ddn.com>,  Bernd Schubert <bernd@bsbernd.com>,  "Darrick J.
 Wong" <djwong@kernel.org>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Kevin Chen <kchen@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 1/8] fuse: simplify fuse_lookup_name() interface
In-Reply-To: <CAJfpeguuLfaqG_JBapk9weWbkht=uuvzMfAPhXNmynxb4S6g2Q@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 27 Feb 2026 16:46:43 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-2-luis@igalia.com>
	<CAJfpeguuLfaqG_JBapk9weWbkht=uuvzMfAPhXNmynxb4S6g2Q@mail.gmail.com>
Date: Sat, 28 Feb 2026 14:42:24 +0000
Message-ID: <87sealx73j.fsf@wotan.olymp>
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
>
>> @@ -570,30 +571,34 @@ int fuse_lookup_name(struct super_block *sb, u64 n=
odeid, const struct qstr *name
>>         attr_version =3D fuse_get_attr_version(fm->fc);
>>         evict_ctr =3D fuse_get_evict_ctr(fm->fc);
>>
>> -       fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
>> +       fuse_lookup_init(fm->fc, &args, nodeid, name, &outarg);
>>         err =3D fuse_simple_request(fm, &args);
>>         /* Zero nodeid is same as -ENOENT, but with valid timeout */
>> -       if (err || !outarg->nodeid)
>> +       if (err || !outarg.nodeid)
>>                 goto out_put_forget;
>
> And now the timeout is skipped for the !outarg.nodeid  case...

Oops, yeah I missed that.  I'll fix it for the next iteration, thanks!

Cheers,
--=20
Lu=C3=ADs
