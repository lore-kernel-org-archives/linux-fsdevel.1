Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E61A9F96
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771012; cv=none; b=IIrPwKyQdGVU7WdWOuGuP92vE/YXNJWaTyE04dVewAyh/MjixLWehMlPOW6UcT7nrH71WGy6bfnN5aBqXZlLIAAkrSxqWSoNxUPCzmJ2Jko7Eoa6FzHzyL7eAweNDcBlgGLnxsXkYG/fZoEg2ImO5oozudSrGHpNfI0nkeK/Iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771012; c=relaxed/simple;
	bh=BM8f+UAvgC6ZJFsexAhcbhWYsQ7uQjqxHxmQnEI5s0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPCWpVBU/PjbW+cASSgh0ajKWSEEpscYlI/JjnY1IrnpnhHoShV7U2CzrW+/fmLiC19UrQkWhQs8zJCCLLGgiDK0Li2ltiCFUYc/0YHVIBl+0u0N2FtrtNSolq/IG1NYiDJ49wwI3JzevjyFQdap2+xa98tdW06pJFsLbaGq90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei37P3Hi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei37P3Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2041F00A3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 04:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779771010;
	bh=BM8f+UAvgC6ZJFsexAhcbhWYsQ7uQjqxHxmQnEI5s0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ei37P3Hi0sDGy34uQrLOma6fZoto5ZTHf275LQDyoB16vdoD09xjWm3JdF2rV3/cn
	 bgYt3cWIKkwJsU3Rp/sXdmxEVAwSTKHdK0vQzokuWkZlHPpAi/Iz/Zk4P8kUiC1jxl
	 +7xesvvXciZAEff7SZdCdjnxyZF0ZpUdJJz8STFtFZ+5TNPY7WhdisgzRer6kgbISC
	 2DADVSeaxlF30jsx5jL649/46P6W3figpHdeMDyJ8/9vwTGFiM31iiLG7TpcQHbIcX
	 5I137sb+Qh7PHiJXGSuYukjOreBowmjG9hQ7cGwTijGpvRJpq+n69ookfzFgmpUJi7
	 xUZSvnEhAuyRQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-689be822f34so2144671a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 21:50:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw1HPIob5dLX86LrIJ8ntXHZr9WLgWdftN70gevVmQpKzLrX/P7
	gQ4YqDC93c4DIHBbT2vjzu+C3okFq7JJVU6CIwYnaRg6vRrapv6gGmuYiD+z93tD9JLdvCAQaS3
	pv+SETXwsusU0LTy6RzJMcYw8f7t8K6U=
X-Received: by 2002:a17:906:8a62:b0:bd2:149b:1f99 with SMTP id
 a640c23a62f3a-bdd25aef15emr687578866b.14.1779771009388; Mon, 25 May 2026
 21:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com>
 <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com> <CAG7tbBWWw5pN8OtXyD4f=OYTZqXzOsm4fnj=S-sZW2tuG_FqRg@mail.gmail.com>
In-Reply-To: <CAG7tbBWWw5pN8OtXyD4f=OYTZqXzOsm4fnj=S-sZW2tuG_FqRg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 26 May 2026 13:49:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_nGc4G9gQ8jLP05hjJG=MUmmKS=nBSUTrB8GFbYWHO=w@mail.gmail.com>
X-Gm-Features: AVHnY4K2jTovIxQ8pDSHxo2ujO5KjK8OjbyMI5cyvfxAhVHpywmsah9HCw71ACI
Message-ID: <CAKYAXd_nGc4G9gQ8jLP05hjJG=MUmmKS=nBSUTrB8GFbYWHO=w@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve benign secondary entries during rename
 and move
To: Rochan Avlur <rochan.avlur@skydio.com>
Cc: linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"

> +void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order)
> +{
> + int i;
> + struct exfat_dentry *ep;
> +
> + for (i = order; i < es->num_entries; i++) {
> + ep = exfat_get_dentry_cached(es, i);
> + exfat_set_entry_type(ep, TYPE_DELETED);
> + }
the tabs and spaces are broken. Please send the patch using git
send-email, or attach the patch file instead of pasting it directly
into the email body.
Thanks.
