Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE91E5B68
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141064; cv=none; b=eAzYyWz1rExuByOfvCFHXu0tHa0IPoS9S4liteexVzPI+Al5geD3BJNC/UcaOyVCrI9FC+fvt58isdPJvaKvDtOrDPt/2YovOaaRjx7oZ41BX4tB6h2yB4NS5Uq6pxCpsr1znBV/Oon1jXOMvPHgrQWQWkHy8tCmETd6nDu22Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141064; c=relaxed/simple;
	bh=fDcWjpqTCecuJSRi4u3KpyL1bivy6w0IvzGBwYRN31w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UBYrfGRFUbhtHzFTvcAwGuXSFY8Gd9J2Q374DDZk4xJiwfKh7gGEhIi0ytEU+Ht8+282oElsaGzzSr5Fce1u8u1MGlj/2Lh49hhT8nZUwHk26v440Nnbo7Ih75Nakj9u5rLyGJxif2wETInnbKL6E/tvnYYXpbHcNdd8ov51cQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yb4I9RAl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb4I9RAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785141062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO233IBA7Ts4NqEpH6DUM0Y6A3gOS3qvmUNEqtwfhU8=;
	b=Yb4I9RAlKncpeIZXeNxsNxpai3TVeigGKI4Up2H/cUfRoukQEEUQ+3hSDt28Hq1OHDkB2Y
	6Ev9Iu31r28dQEeHwx9m0F7fhWiIshYIlxO/ktt9aOfi7CJqEYQ59i+m1fz2IqaUlqddjo
	NNxlq8A/MIekAipk0QdVz36bG4Cnizg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-GaMENHFvMPWw6GpTzHfydQ-1; Mon,
 27 Jul 2026 04:30:58 -0400
X-MC-Unique: GaMENHFvMPWw6GpTzHfydQ-1
X-Mimecast-MFC-AGG-ID: GaMENHFvMPWw6GpTzHfydQ_1785141057
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154091955EA5;
	Mon, 27 Jul 2026 08:30:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1D9D180057F;
	Mon, 27 Jul 2026 08:30:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260726182540.40891-4-Akhmad100913@gmail.com>
References: <20260726182540.40891-4-Akhmad100913@gmail.com> <20260726182540.40891-1-Akhmad100913@gmail.com>
To: Akhmad <akhmad100913@gmail.com>
Cc: dhowells@redhat.com, gregkh@linuxfoundation.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] fs/cachefiles: replace simple_strtoul with kstrtoul in bcull
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <968924.1785141054.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 09:30:54 +0100
Message-ID: <968925.1785141054@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Akhmad <akhmad100913@gmail.com> wrote:

> -	bcull =3D simple_strtoul(args, &args, 10);
> -	if (args[0] !=3D '%' || args[1] !=3D '\0')
> +	ret =3D kstrtoul(args, 10, &bcull);
> +	if (ret < 0)
> +		return ret;

Nak.  This is not an equivalent piece of code, but will cause EINVAL failu=
res.

	static int _kstrtoull(const char *s, unsigned int base, unsigned long lon=
g *res)
	{
		unsigned long long _res;
		unsigned int rv;

		s =3D _parse_integer_fixup_radix(s, &base);
		rv =3D _parse_integer(s, base, &_res);
		if (rv & KSTRTOX_OVERFLOW)
			return -ERANGE;
		if (rv =3D=3D 0)
			return -EINVAL;
		s +=3D rv;
		if (*s =3D=3D '\n')
			s++;
		if (*s)
			return -EINVAL;  <---- here
		*res =3D _res;
		return 0;
	}

kstrtoul() is *not* a drop-in replacement for simple_strtoul().  You shoul=
d
alter _kstrtoull() to return an end parameter too if you're going to do th=
is.
The end parameter is quite important.

David

