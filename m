Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CF393DEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609229; cv=none; b=R3KUon1GwuWVO1M68eTYARRY/gQXhly70P8GJiOfbg5XwAtWp72WJSP8icAjg44MlSt5P/6Hew1ipMqRapRyBBcSsOzAlStU3eboyFyL5UlHB/XZuEYcNB3MxeLcD+e2P/pHFToqothG1MvCDVu/4Ip9XTpZvOYmc80lIXKnA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609229; c=relaxed/simple;
	bh=FZJtR0w4GJCui3/VxgKSPznCm8GNF9lnWrpVODY0xqI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Go/IX0FFGJm42UKsGx+AUwu+3FixwBtguEPaM1xoBg5doLbTB920lFo4WMwjI6xASV0zO8FNyvfbbVGLYYqdEHLG9g/WFc7iXXdkyNsJ8wl8LzktKrpM53ewtGsFWcogMfwDjHpDDQ3wiuW4BZ6KvVgHfyWSZT5N2mg80VueCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DeSWxW5w; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DeSWxW5w"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9349ad9c857so320005285a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787609227; x=1788214027; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cJ9fg/zk2IC+Zn+5lDDiE/TIZcTQB+rQho1o9bYREE=;
        b=DeSWxW5w1dy0jKxn7JdbNLtZIR6B8PYpnK7vvWAopWAfq6fbBEffZrnYlhhZM9jlia
         QZe43YIq5NWZxQvSyuTny45vuLuCJ7w0y4jvrLaIzqryBZoWKEWvwjAYtVksw4Mn6ryQ
         Ivd/dt1h6+QaIpVYBN9b0IU3Adb8gTQ5POIo8xgonKmVDbO/wyCnOuIzsNReayE2TaIG
         /2bNZcL82oFRDNEmnO3sX6knVP+RpVtjudF53Ds1gd1/4GD2+98QvFgnKHKZWwl7/sTe
         u8m6yHEY3YB80X6vFwN6pKITPEtkJweUBXxz5dO5OUqGkRe877QLFjBr/7PetIxtH7Vr
         3WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787609227; x=1788214027;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cJ9fg/zk2IC+Zn+5lDDiE/TIZcTQB+rQho1o9bYREE=;
        b=rXXFLTutCSPf+YMZWLFDtWkf4AY3kCtBWqRVPsUOZE/1xhvatEXIHAojMaIw4KW7Ub
         oZCMTxrXJ4huB3lgdtjGtS4Hg35SP0dOUVOPyKIy56zILuJe4rRtb/nY6CEE2XmFjyQ3
         v5TJG4d8yCmCQ1p1qIdpESZrAw+5fr20Myp75OtaG+bOM6Y9G3Oka5Shp0poHlZpMvSW
         VoH8fMCUfnJR7zVLe83DTZzVIXOar23peGTuPoaexDrjlYGOq3tTXrtN2osoNKyx6jk9
         DhDtPoayXEcia1Jdt/coQDN/rR2Rvga/oGUweME0j6MASxNO4R146435TdF9ApYz//bE
         /Sug==
X-Forwarded-Encrypted: i=1; AHgh+RpGcWn6zJwcMqieLxgcmrgZyPdDjJ9KqJ+6ZnE2MMiJSeJJnQXm4WSx2qJ0En64dKwIjaAdAxy7OBecBFxy@vger.kernel.org
X-Gm-Message-State: AFuF++mgyaYVTe5wfJQSoVjYr+5XwmKKHPrT+NIUH8djVczjUjeWeqHe
	W0PC/IQ5hdHWw85oQXDhbWthTnjWP/GYSYIQnTJSEbzABwSBAOCqF3yefOZ2aQdavg==
X-Gm-Gg: AR+sD10HlfMgILsB0HH+l6GMmXIA4HLTYb+8ILdigQn/bpkvXamGlFFTttHW0iYUZBB
	q6hvDJ5Aji80dwnmrUI0RVLwdt+dD96oEeV0OGNvQFf8oql5kkAffCtcMvlWNvTgFR38PcP9zQT
	waGQAhnXSDdUtTxIs7pIGvEwi5MZE2PkplxzrWzEiMSTxWIt7QBkdnE60T/RbfWTfeMIpImfIXM
	E6sBq0FF+OeQEKkHu4rzLDu2UPjX9g7F/yyXJ5wHLJ2UhPwOIYiIcmeS2KapsZgJWeZRdikGu9c
	85Ncd7B1mc2t19j2BmwNOgxOU5t9ZlAZnZVjtsBzKkBJN7baaIMiUoCdgd3Dgkxoyd+diEhdGYT
	XTCBuQlABL6sxpr3Qo91dAbevkocpZY0HB+8R4r+DfwNbcoofLKD0giUXIhSf1STvSLBGqmz2HO
	WMlOAlT4hooiaEhhZghWiBqjyGBYse9GmtBxb4EXWhLxCZ55qQS7XhKQ3L/1DlVhPnZzHgIEBi5
	RUVuIihNn/+78qfoqXEkSTtwfNyUinXEA==
X-Received: by 2002:a05:620a:1d05:b0:92a:3679:7978 with SMTP id af79cd13be357-9376f9b9b8amr279389385a.18.1787609226991;
        Mon, 24 Aug 2026 15:07:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749af1f4bsm592605085a.18.2026.08.24.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:07:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:07:05 -0400
Message-ID: <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260824_1800/pstg-lib:20260824_1107/pstg-pwork:20260824_1800
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Roman Dolgikh <rmd4work@mail.ru>, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set by  fork on exec_binprm
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
In-Reply-To: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>

On Aug 18, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
> 
> Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> Link: https://github.com/user-attachments/files/20751461/fix_audit_proctitle.txt

I did drop the link above from the commit as it is contained within the
link below.

> Link: https://github.com/linux-audit/audit-kernel/issues/170
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
> Changelog:
> v3: use previously assigned context
> v2: simplified to call single use directly before need in audit_bimprm
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into audit/dev-staging since we're currently in the middle of the
merge window, this will got to audit/dev once the window closes.

--
paul-moore.com
