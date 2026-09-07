Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB526AF4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819493; cv=pass; b=okuCUhNyQ5ojRtPAWt+u19B3hfhEPuz6VKymP7M+PNCbn7qwFeH7uOWZEXQTaZe1FVwPGMyqCqIWGEOq33ZQ03SiDYqSWmus41k0Qg7vJjgbThFrhtj55iCWNSi+x3E4Nm7+nQHTpWpEs7J5gAoS84KI9+sOfSHzcG/0I9k/7kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819493; c=relaxed/simple;
	bh=ZdQ3JbGEBj66Iri9bXPFZvgMyN/PybvpINhIicFF/EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpCMPyNrIFiN+D+sdu5FlKAKb/slZpdyXyMn2GTTz3vS7y4Wg0Bu2rQa8KYcPu6LsHEt4SrCEFRg1/scRumga7gArIDLFuTOTWpN3hgcqBT3W3a4KqL87g7kblvJ7MYCDTn27GmY9v95ILfeww/BjClLFkLoxrnRcqpNDHWqZWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpyxuA40; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpyxuA40"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3081693a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 15:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788819492; cv=none;
        d=google.com; s=arc-20260327;
        b=ngb2nkKYZUTQsJ/5WesuJKF3NK0hT6vroqbr8XznET7RAtGj7qiMu8lbPvkzpjjQn6
         OD9w/jxd18egq2Rn5DFG92wW5dqfIfZeLFmtsiYfKfKCvgHgCb2w5+Uh9orCw7RqAXfA
         hXyCNu/7HrXj08TkUehsPjVIXhwuvn6MCwP3mD2pP+H2qFGPvf+8FFNLj4Dq08oNqC7Y
         M2SrTi/K37Yrl09iuaw1GFH4p/6ij4G6Y3TZavE//S18NBxzIFLiki61oWF8T77aJ/cY
         XMPgbqRMTFYYj/45SwoFjc+HCtQ1mgn5Zvlo98E5OQC2oBw5BMGENO5khZ/zDMWl/3lw
         NPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jNlTXyDPKBggEGyMwYYgjcO9kU30dwD9XLhdPez1l84=;
        fh=Og0UU6Syd6EWJ+Hd0m4KDN5jQEXsS4XNKHZzbNkpGLg=;
        b=jpJVGZWlE4RxwJah1hvePtzJvffvR/d/9ERZAZkjyjV//BewKD/Eb4NqDhL2C6lvvS
         mATmFY7dI5gA5rSmDoJNtJ1mcbs6zc3pscmYVmWKN0diGG/W+wK7FGr7+iZYm3gRpv7z
         u1I/x84AgGu6qtfoJsi86pfO1hk6j7OEDgr9eriat7xfCEw0fqo7GrtqcEXWv6jH9L+u
         k5OJe6POQhSzDeFf3dq78QXmt7WvqDCxkMf3+xj7it94TLFWCYrA0U/CH95xNELvAmh2
         dFXhu5f0CSCGA6Rr4KOnQuHFeds2nmKQTXmroZq+GG8u5+QGuQnjc9z1OIxmEgNsmXbo
         gVTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788819492; x=1789424292; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNlTXyDPKBggEGyMwYYgjcO9kU30dwD9XLhdPez1l84=;
        b=gpyxuA405pfhfXiGIMx1EziqMPmw5k+AfeoYjX6GWiJH5nXMvUufy17ErKzQJdrJsP
         YFLCQSh/he5lOnjY28WA1eM0VzjJG2HizQf7b53oZ8R9y7JB74tr6RZyRrza90vyuOjp
         niYC8FCUDSsjr5cuJcDL2or9TLjVncQLrnGD3kkqs476rd/txfpJMCDsdgqp8ygpTC6I
         /IaP/YXo/3wecobtyAW/kcfNJA8HOqbWTSeZGfnpZ3SnceW1wX7/M4+levpUiiX666ci
         caCQTir3leVBQ4+QCPkG6zo4zVM1T5kFuwNs0BjykEPUaTFp2333tnIDJWjlLwHrU+QD
         6aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819492; x=1789424292;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jNlTXyDPKBggEGyMwYYgjcO9kU30dwD9XLhdPez1l84=;
        b=U/skNW/qLkqplJzFgfswu8HbLcUsX/breU1LEHQD7z4yp4lIUQEQvFFjMerPoFseqi
         3GP0KjN17baDIClS+O3fD2YZn1nurmNuvSxlyS+yF/+AUwigPtR9C6FtBUGb3MwywRTV
         2NXwDKI092zA3qQRPoSMgulvSlrpN60e/M7xKFphMHns3RVx9loQCNtwHhX1UXJdYRPs
         Wgnv9rqTKh4jEKMhHM7Hjphhi6KcXeB/JsIb073mV78w1+6SKCpnIT7YMpWk3fgLjo7A
         raLaKS7gtLruy5DU1o7poHH6GIb1KiM6op1rG8v1hepEjG46WSh9Fa3c2rrqqdooCDRI
         fbaA==
X-Forwarded-Encrypted: i=1; AKwUvBzs422lr288i/IjS7p3mbsrxKP7I/EW2ECpgkvqeIzEJgUkZg1kGT7HFbcuBdB4TM0Bp2fDm/163Nbpgd/I@vger.kernel.org
X-Gm-Message-State: AFuF++nfnitVFMiLAc2OqyCpYnBRCFen5ae54KYBhW4irpx2MO/A+Pzn
	CPiICFTY6LW3xPo4HWV4bESWj29qAKcIRqDXHkRa2jzxtVpqmYxCppYWTfADNqVV9l89iZQ1fTf
	/i6AGNws+if0ai//73C48pvf9zo9jUUnanwZF3MxY
X-Gm-Gg: AYBFou3jLa/hFf/C/kMaYvKdtXpBJRRlZ2XFS55HZ2hlhG/owWhHmnJoCMwlThsyh6a
	2LkWvUPZs5ZaTUSBYfEfXx56/Szj/WzsRGzHHW665T3m2yM+iMWQhW99sydaSWcTDQQil1DV5j1
	E20+T+xTrgW0rjW7kiDqIwZ94QhZlIt2sIOlXR2Odnrj7yasUTNY19107Lbnb3Kw74Etg+XW99e
	sHDWZ/8BwXdSap3GUwdY1i5+L5WjCmscFn3eo6k4obOP7401rcgtWpgh3eO+97+ktg3ZrsUoqV6
	Faod4FO6+n3tpjzVERG5hV5pNIKQcMDDAKhxfCIbcF9hTfsw32D13EyzVSEhZyio3RvrclrZrHs
	NiX+AHQXmGA==
X-Received: by 2002:a17:90a:149:b0:39b:2b10:d05c with SMTP id
 98e67ed59e1d1-39b2b115ba1mr26085066a91.5.1788819491324; Mon, 07 Sep 2026
 15:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903101843.3462767-1-elver@google.com> <20260907221334.GA1619741@ax162>
In-Reply-To: <20260907221334.GA1619741@ax162>
From: Marco Elver <elver@google.com>
Date: Tue, 8 Sep 2026 00:17:34 +0200
X-Gm-Features: AcwNN1Ud8SWGdY6soyCDfiwuMYKmM_SUBGIs8OdKM5eZuw6s2ybWmhPNVxak0AA
Message-ID: <CANpmjNNuiX-rQFvn0GK1SxAbcxEUH7rKh69GPq+7u2tg63qbmQ@mail.gmail.com>
Subject: Re: [PATCH] once_lite: Simplify condition handling and fix context analysis
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Jan Kara <jack@suse.cz>, Timothy Day <timday@thelustrecollective.com>, 
	linux-ext4@vger.kernel.org, Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Sept 2026 at 00:13, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Sep 03, 2026 at 10:16:38AM +0000, Marco Elver wrote:
> > When WARN_ON_ONCE() wraps a conditional lock acquisition (such as
> > down_write_trylock()) on architectures relying on DO_ONCE_LITE_IF()
> > (e.g. arm), Clang's context analysis (Thread Safety Analysis) failed
> > with a false positive:
> >
> >   fs/ext2/xattr.c:825:6: error: rw_semaphore 'EXT2_I().xattr_sem' is not held on every path through here [-Werror,-Wthread-safety-analysis]
> >     825 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> >         |             ^
> >
> > This happens because DO_ONCE_LITE_IF() branches on __ONCE_LITE_IF()'s
> > return value (__ret_once), creating an intermediate branch merge point
> > where the lock may or may not be held depending on whether the once-flag
> > (__already_done) was already set. Because the merge branch condition is
> > __ret_once rather than the trylock predicate (__ret_do_once), Clang
> > cannot reconcile the lockset at the branch merge points.
> >
> > Fix it by refactoring __ONCE_LITE_IF() into an unconditional
> > __ONCE_LITE() primitive and redefining __ONCE_LITE_IF(condition) as:
> >
> >   (unlikely(condition) && __ONCE_LITE())
> >
> > This simplifies the implementation, short-circuits evaluation so that
> > __ONCE_LITE() is not called when the condition is false, and ensures
> > that DO_ONCE_LITE_IF() only enters __ONCE_LITE() when __ret_do_once is
> > true.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/all/20260903072759.GA1750084@ax162/
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Thanks, this fixes that warning for me across all my builds.
>
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build

Thanks! I think this is one of those orphaned files - which tree can
this go through? Can it go through your tree, unless Jan already
picked it up with the other fix?
