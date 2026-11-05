Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793855338;
	b=m8FJiAdma4nennoNUrCOMY4M5DbBExFTOyEFMRuDUBQkRtlQksAnZkWuuRcKwpx4TEmv
	 BMjgLOtz4VI1i/I4lusHhk2LAycYPPTS3ZNglV4PqPW/Zyk9JMDauyXhyhucUkp0OlKJN
	 VXp/jRsFLKCsHgCEE7McQtiGcPjFxV622YXjccS2Xsx+sMW7/UPs/pq5ysMLwlI2JsblR
	 Cebvo0Cr/weuSrc/BW7BHh+R3xbFRsuZWqhQwtgRCRX1/1LO7oiz3CDjn9aLi/eq2pxcS
	 vIvJlK3nP9ZoVVYqcCx4UmeRhA4nb1yKFDOLu2qpCEWMfyYuE1ZWvTg7PL1n+gm7QxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
	b=sI2tyAQnvncToNbGz9LdZLlZIeP6Ceyg8vHRZMHDo5+II4hnozVFnwtBHzvasVp6zId9
	 HsSp5TMOI35o1J6Zbr1t3nRSi8isL/5/vMlHd++OKe9otMV8z11CjMDjE83DFclYyTx+f
	 /Qr6WS1mNxWHbp+uxad6c3rAIAo//KMZXizsLuMR7+qOqwjP+UoJNo9GZQSP2t5f0flb5
	 33+cQC301NG3GgZGWxDqVniVFXM9o3Me6ZrQlEN5JoZRbw0hqwuATLcWXM+Ln1sI9Uvw7
	 R/YaeSbhQfwYauayVcrzrVov7VWjE8cV7wza/r1mdXH3Auoz/1X+5FcD062wx3HwzxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbcVMO+d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1735606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 05:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1735606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbcVMO+d
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-550f311b527so629519b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 21:08:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793855336; cv=none;
        d=google.com; s=arc-20260327;
        b=nFLy6MYMntirTcCRvOP2IvcIEM53iq1DZaqljUAe8ltk8WCe/8jbdodjDtLphDiR2Q
         zbhW1szMPz6S49O63GTw71UBH9LUzJytc08tBnv4EEIikMOBxWqbfpgTdGyh2QS/F8lE
         mxcoX7TIqUaJ5N/HQa1it3V0rdTaHUfTzwcFC+p9q21PHe5OHzfAaaLBjlpj8X93Pcw9
         p/l7ERqpCn8lxhg0aNZc0hnHAGyfW4ELNF6xTRdDH4hdHX/01Npbc6n6Gv6tKJkUrod7
         A9sOy/UzPwO90uW5wdzc2BTq4jfw022yXD8TzrmPz+uOxrYYX+uPHqQlTMWNH8snYLFs
         IROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        fh=PT4xij0YI934TpxZc5yA21JcQ8C1ePyGMDo56+fX5EE=;
        b=LX9Mma4c/FrYtLqNwyvY9ukoxkS+vbHBLu7k2dG7b07xwIEtrtrbFhLNBYLneMk97q
         U8+IjoSOXqVouY6q3gVFpe6yCXCXotaL3jKWO9YUqX7Rnx3DlZNceV5reTSXqvJiwJ4s
         /ylu3RVVWmB8ALhryId32BHYL8Kov9QpDhF5VtX0SqFH/ZPIAO6quTvPzq7u6T+oOokQ
         LF1HL3/Nv/mQbEIH39xt0xdsxNX9AIMNeg2cRtKuF5ApV2wG5w+5dnnErdzTlcCQtbaA
         HAkzj2XN7PbNfK1tuG3EommvVfLF049fD9ZnPt00Kr4EsiuGAdlIUZojmm8jkeLlrdm2
         nb7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855336; x=1794460136; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        b=ZbcVMO+d8qwcr+LjKwI1ovUtnV2jtZiGCbR5yVtezS/VbJnmpZgAhibdGeCD+/j+b4
         ROiLVWPNDPF6rQsv1L1xB1tg1yDghKBi/J7RDgR9kIRH9qFjhNTNA/adF0iE88qheNyR
         t8jNAFy2uFAZcrG7qNhqs7/mXem6in/7z92u26l8SqSXyBwrMG9VN3I/oSQr6V7hHe5i
         qCeDReNgvmU5Z26E9wlUDgezEiILY6BVPG2Jv8SftgJfvUmyC0BqRMYna0rWr8LQdyqj
         o3HeLuxcTKSzg+l1U1SHMkD/wGN/t/u6+nKkNKfUxyD7E11Kr/HZFeQN8TrWpZMtQCoZ
         C6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855336; x=1794460136;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        b=Hzu2rDs+6OI1r3MpE+1ohCHfV/4YvfKfiUSgM7gCcCXak/x9GYNMXkjT9Pf4ICnhwb
         JNmC8B9J7fDOtUIMp7pby2SptuSMevNoJvaT0kH2IHqsIROWdPjHyQUHjLKSJkos2+xa
         qo7BDYZSvkiFUUSiQCuf1crPxEtCv17pXn62WUaX4HykvIRWQ9fKOk63dnSUXcUe67BS
         sq7EpjwN9bGZdX2rBQ3xkC8bA5P0EtBzs0Vfa9cRwA42rMU+ngTfBvmDdJZQkWPo/JNG
         uBQ5g+0lmvz77cjlFvAbR+zxWsJ6Xcs0BDx85Vwi8BpNUuqnn4/snnaO/AFePqaup0jg
         i/ig==
X-Forwarded-Encrypted: i=1; AKwUvBxPwXiZRHS+KZtmRMAHf/FnZG8uZlYosoI2DMbcZCieHzyIX2xYPDXWWMi0bKsLOZ8mKsySMuxsfWof/qJZ@vger.kernel.org
X-Gm-Message-State: APuU4Z99Hje9d+1iUpfy/uExswFqttH2OX28smuZ1FR9eEkqWvRiRJ/G
	Tuz0oAs20VS5JYXo+1MbDQWw9el+90RA33EYxa4brPfmKj8wPHbsGdZwGnvo9rZrpCK0+84S4ti
	OsKpB/Mr0LGLoYfzc9ytU4uwahVJbhhs=
X-Gm-Gg: AYBFou17VpkT1QiKTlkwWMlryxPYSbCh9+Em79ORozg2KLugatzMVPiOU333LK/vgSY
	xH8zIOH3wYvrSijc96Q6FC2wEZdA64W3u/Dvqh+qhx/h3vVot9d5WMg8898UULCinAaxPC53t9y
	DdRsUC5t3r+T7sWLz8cNCMJakr0Iffq9n7raxywO2pheMqUu3Ep30Qzyop1bJq+GCfbekKSWok9
	ZJ8iulZ8Y33jNo57UbPEiAtY3+Yd2BOkHyQwx1gOkDX0Y7g1hV4rkfl6blkhYB/nAhorr9VTjgm
	lKvPb6KoV+dcKF3kWwMZcGZn+hbJmV6JszcRAXr4okYwAYVZOgy41ce/b5eS++JHa5bjO9P0tKH
	LvwjXH0WVt53M4UKkrArkgkHanSQv3SuuiAh04low+ZPSxzzQCoVTmLx/+ngzcoDORotx7FwWdY
	rDqlWox3WjT16TcyuV1f+Onu3ttJvZq55QC1u7kgMZDpv7HAJMJodinj1KvJskH11blBB+UG1bF
	U0=
X-Received: by 2002:a05:6808:198e:b0:4d6:9293:9b56 with SMTP id
 5614622812f47-5640de2e892mr13926693b6e.62.1793855336421; Wed, 04 Nov 2026
 21:08:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104191355.89544-1-dennylin0707@gmail.com> <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
In-Reply-To: <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 4 Nov 2026 21:08:45 -0800
X-Gm-Features: AclHuK_8naWfPmbeC6CGznX_C73hXCMzOor5rRkYJ7y1u4psfW7icnRznn3rIJw
Message-ID: <CAGEkeHfnyyggAXOUy8MW+UT-B7FrG9sPWcO3CNysA=SwGp0m0Q@mail.gmail.com>
Subject: Re: [PATCH] coda: honor the append state of each write
To: Hungyu Lin <dennylin0707@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Why do we now have cached copies of f_flags around? That sounds like a
> recipe for getting things out of sync.

f_iocb_flags was introduced by 164f4064ca81. The VFS initializes it at
open and updates it during F_SETFL, but Coda's direct modification of
the container's f_flags misses that update.

> Anyway, your patch subtly changes the container file we write from
> cfi->cfi_container to host_file and I am not convinced that is a safe
> change.

That substitution was unnecessary for the append fix. V2 keeps
cfi->cfi_container in the write call and leaves the existing i_size
copyback unchanged.

I traced the container reference from coda_open() to coda_release()
and could not find a path that replaces it after open. ACCESS_INTENT
does not return a replacement handle. The container's contents and
size may change during the upcall, but the existing size copyback
reads i_size through the same held file reference after
vfs_iter_write() returns.

Thanks,
Hungyu
