Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E634CFDA
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191162; cv=none; b=krUv92RpAPrkOCHRVjWC+sWE7rUSw8pxaFA+gx+nOwTuLRCiUlTGHwk4DYry/4RukdIW32CXsCaRcJG+n9ZAqMaAbX+NuCmOAJ3jRKVr6L6Gz0/F//mPuwPORrJPssZs3TONQM4TLrQ9/NmjPJbbxlmFACl61LL1yXT6SCk1jK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191162; c=relaxed/simple;
	bh=BuWSOKhbtt2GDI/M7zxMYOUygMr++Vaan5JfsxqGDk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDY9z8OEeAEGt6EKHW20okNJxvxetJca6kwHzP9fdMSXKqvuom8au9XEkpyZiepsaGdBIkv/5+3/NG+dm8RimG7iLHFWETqkJwbFQxAABGS3K1VdQkImI7/VddP6YizXNGdXgWyq/i90oQgxB403ixYGdLxorN4EN7lSKbAkM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrJ5tYMY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJgimZ7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrJ5tYMY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJgimZ7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778191160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdpNipRLfIQjSiyltOL7VmMlPqhE1kNFiVsa8sH8oc4=;
	b=DrJ5tYMYcp21JsREjvfU5A0d70YclgRiIlwqq8YHXUh0rFZAFBe2FOLE7nDXhl42EfkCdj
	NnqOX1TWHSQOQOE4aCM5spGFafuS4bVSO+S7OrQoXFHtFsk/1TcS9Ye0231PDvbM9XuOYj
	x0dFW0ibqfwuccOK7xJs4rSg2tQs87k=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-eoZ6sb7RNPOVoKKk9Xfoew-1; Thu, 07 May 2026 17:59:19 -0400
X-MC-Unique: eoZ6sb7RNPOVoKKk9Xfoew-1
X-Mimecast-MFC-AGG-ID: eoZ6sb7RNPOVoKKk9Xfoew_1778191158
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-65c364b8683so2511309d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778191158; x=1778795958; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdpNipRLfIQjSiyltOL7VmMlPqhE1kNFiVsa8sH8oc4=;
        b=hJgimZ7nbaPoleEf85B9V/0SM1XcAY6D6ZVYTduj6k2dagCbjaf39/z+H4e167a6Fg
         UZTVbngb33e7o/lLOFKKcoOkpDUL/c5aJxThlZQMi6i+7EnNzTesSP9rJev2nxQf4N9b
         NeurcNfggATDNDeuCI7U5cUzENfFKPBjp+6V0Sy3xJ7uGYiuSBp/E5DK1Idvu4D8xXi0
         OgrFhNxZ+gJgYzFxJOLWXkJqDwOjMHrO+fnKDf4IkcruCS+5Aa5iG4o6Q0hYUMgjzHGe
         SnYBIpDwV2tbRv2uV8mKWNmiPXou+20Gi5iDG/EvVA0oTJYeu10UjJJvnbQR9vxm9wIc
         Bn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191158; x=1778795958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdpNipRLfIQjSiyltOL7VmMlPqhE1kNFiVsa8sH8oc4=;
        b=CZMBQSh/hpcRDd0as20vJiKMYkqjjBLFJ85eCWFmGEiQ8hzbld67mk2GmHBOslgGCo
         WyljhJsgrh9SwnsvzGIFXVo2NwPD4uxNec4+u4f18NtJPHhRJZUCbihUIuGZVgg3GMrf
         lEygnrlXO+cbi+/6lPpoGCbSnwDp/rWQMUrFEp2pusr9pn5/Bq9etrTxdpt+pNBgrwsS
         a1Xv1s3alHm53c8xwD1rYG13RNoKP8ZLatNJUKE+G8+JlaSgOEP672ifdJjOYdVRRrCI
         ChanE3cKyVb39Mk7hmkEfXhqQ0OumZgRVVwKs7HrxXmk04xWp/WBVTX6H8yCdKBj/usz
         f47A==
X-Forwarded-Encrypted: i=1; AFNElJ/Xve8UgykP1PD12BiQpAV2Lt9dGsVV7lCp7/9dng+cJIB5ZodZ7ey/2lexWco8B/rF/+kV5ruEJS53sVzt@vger.kernel.org
X-Gm-Message-State: AOJu0YzSazneqySE6l/fdSRXNj+3X+Eynh7C01JJl92MNJ3ZvqcwXHa9
	nZKr3m2i36+4oZL51Oo0Xhmp8Fxw8zWtpmDJ6kRs2rOl1dvx0udJ4ew6rFVxDJTHTxM6gyvynIk
	4kTPLqYyM9v++YTGc14QVgbueYVBpgxk7IoWB1OWwrKmB45mLILvBrESPzZn8agGlgBg=
X-Gm-Gg: Acq92OGfy7LGdiyBzancdLGyU/6gO8PWKJbgMPiY81c4ha0FNVLIbkSPkDRF88hmDNu
	a9mXhBu4aouPxvMUTFvIpLuI24Yoia2zxQrLZ+CSLBVlTjX0HygYmqMr4B+zqRagbDS6XpQhYas
	T5RqQVk+4nnEqXAohLNAuOIHISNd8QsRxug7HYLH2LDp+S0ET4+uigE6GBC7uh0eaz4evZ2fGOC
	vkjxY3qlpCVsJvSTVigf+8ClZ4YGBw/POjo7+JwW77yBSElBj1IXgzQSTsXaBx81VA/3YaJ9on/
	iFCrsiZ1dSjMFCseQ2JQ16Eqs0uFaIay6ccyxPFqvXaGOgNvJS+DkdagoAdyYFvjkrJaMLS9sR9
	Q0MwXKcXG7iN/karAEtEuXYx45W5P6/jgXSRSupMKrlVVQs+PQePE
X-Received: by 2002:a05:690e:4085:b0:65c:25e7:bffc with SMTP id 956f58d0204a3-65c79cefb35mr10139542d50.7.1778191158312;
        Thu, 07 May 2026 14:59:18 -0700 (PDT)
X-Received: by 2002:a05:690e:4085:b0:65c:25e7:bffc with SMTP id 956f58d0204a3-65c79cefb35mr10139517d50.7.1778191157799;
        Thu, 07 May 2026 14:59:17 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm98288397b3.23.2026.05.07.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 14:59:17 -0700 (PDT)
Message-ID: <170c26138376d15553437c2edd57ba74d4267855.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] hfs/hfsplus: zero-initialize buffer in
 hfs_bnode_read
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: slava@dubeyko.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 14:59:16 -0700
In-Reply-To: <177817187847.3894093.14769331709936824605@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260505111300.3592757-1-tristmd@gmail.com>
	 <20260505111300.3592757-3-tristmd@gmail.com>
	 <00306449e9bb0703aedc71b01fea2b04e33b2725.camel@redhat.com>
	 <177817187847.3894093.14769331709936824605@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:37 +0000, Tristan Madani wrote:
> On Wed, 2026-05-06 at 12:23 -0700, Viacheslav Dubeyko wrote:
> > We are returning back to the same my question. What if the caller of
> > hfs_bnode_read() provides the len =3D=3D 0 somehow but the buffer has n=
ot zero size
> > on the caller side? I assume that memset() will do nothing and the buff=
er still
> > be not initialized. Am I correct here?
>=20
> You are correct that memset(buf, 0, 0) is a no-op. But if the caller
> passes len =3D=3D 0, it is asking to read zero bytes -- it should not
> expect the function to initialize anything beyond that.
>=20
> The bug this fixes is different: callers pass a non-zero len (e.g.
> hfs_bnode_read_u16 passes 2, hfs_bnode_read_u8 passes 1), but
> check_and_correct_requested_length() internally reduces the effective
> read to 0 due to a corrupted image. The memset runs with the original
> caller-supplied len before any internal validation, so the buffer is
> already zeroed by the time the early-return happens.
>=20
> No current caller passes len =3D=3D 0 -- hfs_bnode_read_u16() always
> passes 2, hfs_bnode_read_u8() always passes 1, and hfs_bnode_read_key()
> passes a key_len that is validated against the btree key size.
>=20

OK. I think I can agree with you. If we have len =3D=3D 0 as input argument=
, then we
have:

if (len =3D=3D 0) {
<skipped>
   return;
}

And if check_and_correct_requested_length() corrects the len to 0:

len =3D check_and_correct_requested_length(node, off, len);

then loop will do nothing because of len =3D=3D 0:

for (bytes_read =3D 0; bytes_read < len; bytes_read +=3D bytes_to_read) {
<skipped>
}

Thanks,
Slava.

