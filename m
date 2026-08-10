Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1863C3C17
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362599; cv=pass; b=EKPqtf6+8Lbgdfj4KEUSPYz9ILKRZkcFQ6Cbn9JGpxm67G4BY4/s55SrkHh+mLWGuV10GGkmt8QlCxTiD+X8+Bk532S+atqsRHaCCeuyxnppMJwRn7dxkWNydC3HvH0Z8YRpX+T89tTVHRH8Mvo1phVPrKnXb+n8+R5yefLw8S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362599; c=relaxed/simple;
	bh=bqxhj80OHCfs2l0pmZXo9T6EE/Q+XSI4ASVci9J8bsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO3UepaxqZEOeYnRYuuyqeN80k6sMzxhMZg5lDExvhgJF+imRAaXSbv2H9QOEaW7efiNOnFe9mNWkv4rqydw3YCseubduDczJW1VQWkYPc+fUEPsY49KVUXE6O/WEYKLNWsnEd1ZQ1GP4CIsy9GO+/HL4xUM2jE6gefIN4kTj/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JbIlTHjY; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JbIlTHjY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e55b62640so71162085a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 04:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786362595; cv=none;
        d=google.com; s=arc-20260327;
        b=dkq9LR0qHwkI2YkXmOCevRKQwQn8u56Tkdrne6VBIGjEOcqQ2tNMP7Xj8AVEHQVAnq
         zZ8/MXXMLby3E71BNvTCqJsAXrn93uJ0z/ThMrTiL6wRbK38jNfH4Erat9j4SlUBoaCL
         +8oFZqZ+eOYgSTr7O0douioHYsFHdxYDQKKUAJ9tFdGfkMyc3zd5LzioOnXsojYZEb38
         EJ7qXp5gEJSUJtEKE5ABZbz5RIRl9sSyEinwkpPdquqb50e9O9oX6S+RJYJ/uAYRXW6q
         bnEf+56/ehZ6JCkVT4BvnBS+fx9MAODSyqiavHJspBIwrv3CG2XiRX7tNwP2XHduKMQk
         a9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        fh=mSShP+y94URqCVNF98mJ65hXgvBT7qQ2LTHQUQaZFLw=;
        b=Aio0YUPlua79IZr5XbGAKW8Q6KpTErkhs7rJa+ra4hNH8/rsaP+msrQB6t3s/OiWVo
         GuqHwUACPHNstiMkYdIfIpCldPrz8Twsi7trGE4KmFqNXwfyYoEbJfmyDPP7/TBGNLy2
         W/PpRP+v2Tplq0SgaZ8Lph9d2n2jtGOWsGNXfpZGyqWIc6deulycgLkNIaVTXKQZmWNr
         kEplc/eWY8Cm9K7PXebsx4CmbVVtCwaooae9sUwLdg1N5/zGv6AqArIbioatVPc5M7hk
         mMXvpPlDE70bumKDLRgNUZLU+NsxW8Vd+DKTuiDWar2+JTym2e8ApS7Tkz7xwvvEQW7O
         E6lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786362595; x=1786967395; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=JbIlTHjYRbq+ZIsCxsszUYyLNHxgDCPjN9Ma1WEhKH7MRmWe7joIBbYWWomP9gcZOk
         LFfIYMBfmj2D+xlKmRu9u/RX7WEdZqwmK+o11C1r04InwcwfFNVdcqh2Sg5WKYqi1/Rt
         KFQGIwIBoE4APpF/F9Jcwrx5z06thfkeft49Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362595; x=1786967395;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYtVOAa94uBjVa65PDPUOymqzi6A36MmnRIRMhhmNoM=;
        b=mj1LQrtoqghz+O3jqF8g3IySj3LQL54oIhXnvP/m+GB5F8Qlato5gYBtaMeCAslIh9
         z1lnr0cawWN/LSDH9EADWAYZ/fCx6hTKEasttShq1HMRVpG7clIAPUh1aZGa69MKjD0k
         TJ6pUtto+D5bYo+UC2TX3bQk4AnbJkFJGaqkjJD9v3ZpVkt7cUbFYGV/DQTXZU7R0rLF
         tdm5v8slWTF+ZdjybW7xr9OaP4BY+hmaA0P5knlc6nAj/zQBcuo3md4MLXR32s5l5Wll
         8yUJgeIwjXr5AVu5Q5z7HjMnfKLP6Rd9NzuvQ8j6dHA0O1n06CTq1QqInwjek35oS3NZ
         UmqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoavDmOcaVjOHc3ffZlFfGoC88v7z8x4JYc3xr+aKdSspLtNI8AsOBNnGve5VOoJPxmqKGwuR+ZdnU8IUh7@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/INh2W1KNNGnjDWEdehmPF+ENJZiftxBtR+x5OADSG9ZiWnV
	7lsstN1sSxAZBu5fWQDF99VX5lhIc3+0aoDL/bRibsQqzRPPUWX2nXU/ggcPi44HBGuOvxcW6rD
	FLAxM1u50ctQupsTTAtqHm8Hnos2O8Zw04JjraWbE4w==
X-Gm-Gg: AR+sD12ZEBH3eNrkVvk0bOiAsSIexVmVDqB+HZqK08XX2pGtxQ2cySi0fHc2/IyV3UI
	6RbzqpJlXhAU1wu/0qMenjhJ++3ZLOfjcgVCiKUk1DW+eqo1P0b4NU2U5z5B29uvtdeYps+6Q+3
	77pJCScfBxoOXOUZgTfN40wX9XGT7pofOQYsBxrmQwOVV+KtFWYARHXkLfHw5sAexejzZNhWGdb
	3QbGifA9XnDhrsB4SkgA6UWyqLuILZbWIiOSsQnOtVPjuWmmFQgGufMzOiz9AHjeY4rp4Mdw9bW
	m1QdinVZe65zRuyNFl9X3h9ygxd5Gyn+sFmihuAQ+Qq7BhzKWBDoLcQFiYcwmFHiHWBzCwpefPE
	=
X-Received: by 2002:a05:620a:818d:b0:914:bf8a:ba81 with SMTP id
 af79cd13be357-9369d1ba3femr59440385a.27.1786362595054; Mon, 10 Aug 2026
 04:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-2-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-2-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 13:49:42 +0200
X-Gm-Features: AUfX_mzmgezsTeEsc_HIV9oG5qNwHpchZPEJUwGx53Ztx5haBzb4JhKil_bknQc
Message-ID: <CAJfpegt1wHngLs9uR943gT6zxV67D53k3n4GiFKowsAb3C6LJw@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] VFS: don't count references through ->d_parent
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eb44720658aff3f2"

--000000000000eb44720658aff3f2
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:37, NeilBrown <neilb@ownmail.net> wrote:

> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first and so never needs to adjust the refcount on the parent.  If it
> remains on the list until dput() it could be the last child to be
> removed, in which case normal handling applies in dentry_unlist() (where
> it has been moved from dentry_kill().

Not handling the parent refcount together with cursor removal can
result in inconsistency, e.g:

 - add cursor (seek between two positive dentries)
 - remove all real children (parent refcount not touched, since cursor
is still on d_children)
 - remove cursor (seek to zero offset)
 - close directory (dentry_unlist() will skip parent refcount update
since dentry->d_sib is no longer linked)

Repro attached, produces "BUG: Dentry ffff888107ef75d0{i=143e,n=dir}
still in use (1) [unm
ount of hugetlbfs hugetlbfs]".

Thanks,
Milklos

--000000000000eb44720658aff3f2
Content-Type: text/x-csrc; charset="US-ASCII"; name="rmwhilereaddir.c"
Content-Disposition: attachment; filename="rmwhilereaddir.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msn63w320>
X-Attachment-Id: f_msn63w320

I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgoKI2RlZmluZSBDSEVDS19F
UlIoX2V4cHIpIFwKCSh7IHR5cGVvZihfZXhwcikgX3JldCA9IChfZXhwcik7IGlmIChfcmV0ID09
IC0xKSB7IGVycigxLCAjX2V4cHIpOyB9IF9yZXQ7IH0pCiNkZWZpbmUgQ0hFQ0tfTlVMTChfZXhw
cikgXAoJKHsgdHlwZW9mKF9leHByKSBfcmV0ID0gKF9leHByKTsgaWYgKF9yZXQgPT0gTlVMTCkg
eyBlcnJ4KDEsICNfZXhwciAiIHJldHVybmVkIE5VTEwiKTsgfSBfcmV0OyB9KQoKaW50IG1haW4o
dm9pZCkKewoJaW50IGRmZDsKCURJUiAqZHA7CglzdHJ1Y3QgZGlyZW50ICpkZTsKCglDSEVDS19F
UlIobWtkaXIoImRpciIsIDA3NzcpKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2ZvbyIsIDA2NjYs
IDApKTsKCUNIRUNLX0VSUihta25vZCgiZGlyL2JhciIsIDA2NjYsIDApKTsKCWRmZCA9IENIRUNL
X0VSUihvcGVuKCJkaXIiLCBPX1JET05MWSkpOwoJZHAgPSBDSEVDS19OVUxMKGZkb3BlbmRpcihk
ZmQpKTsKCWRvIHsKCQlkZSA9IENIRUNLX05VTEwocmVhZGRpcihkcCkpOwoJfSB3aGlsZSAoZGUt
PmRfbmFtZVswXSA9PSAnLicpOwoJQ0hFQ0tfRVJSKGxzZWVrKGRmZCwgZGUtPmRfb2ZmLCBTRUVL
X1NFVCkpOyAvKiBsaW5rcyBjdXJzb3IgYmV0d2VlbiBmb28gYW5kIGJhciAqLwoJQ0hFQ0tfRVJS
KHVubGluaygiZGlyL2ZvbyIpKTsKCUNIRUNLX0VSUih1bmxpbmsoImRpci9iYXIiKSk7CglDSEVD
S19FUlIobHNlZWsoZGZkLCAwLCBTRUVLX1NFVCkpOyAvKiByZW1vdmVzIGN1cnNvciAqLwoJQ0hF
Q0tfRVJSKGNsb3NlZGlyKGRwKSk7CglDSEVDS19FUlIocm1kaXIoImRpciIpKTsKfQo=
--000000000000eb44720658aff3f2--
