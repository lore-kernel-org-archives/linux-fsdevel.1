Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9572E2665
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705154; cv=pass; b=p5GVPwxDiZP/c7p/EPnhLnV0cpvR5zQ6CG3tnOJ3EWVmtYGN6WeXdpKxkkNQvuNw6a/z+o24bxB+zjHmly6NB0CKrGvhpKAiwBsFnrAGwNTtwXRnGQ9hsMyHDTlHMHolx7E0IRnbCn1/dFl89rayzpuvDZKFJo6AkSEpiPaSVvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705154; c=relaxed/simple;
	bh=HPaan3Xhmh/auqThjq8plaiGnc/BrVdNEgT4P015QGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knSu/S89jal8dZOFEZDbLqw0pkAgviMBsJHoJKbocheTaawrwPXBuHSoYpOmfBUMqkqWvIvX8eA8GhaPiCA7hmMDtDUML6XW4VYKF3lK/qdp8vWqU4v8vC55uv2XBvha0aMcuCdJi343n3Wf+zkXYgNuaXOok4SFzzDC6KG3xmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vg5vQmcY; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vg5vQmcY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133362c30cfso706c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 13:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778705152; cv=none;
        d=google.com; s=arc-20240605;
        b=ZK/RNuOtuIEQ4fHIdHrfOrYWXLBQi323SIx7auMD3HozRRahfry9yQ8sHwxiZ8bLbo
         wF7hT+H0w3hXYMcuZWJUN3XHNYhZxqRaUWa1QAIQQI50LQrAcVHZsTBcQ5opof8KDCNQ
         vO+8Sw0mjel/uvEfWBPgtiWrTlMaXpcw6OKwVAjOD52cyJC0cRe5YC1/mZmyUgI2/Jfg
         0f5651Grf0UiTqspP8oc91xi1s9tZswwdtEe0v4x7aqbFauSTdQ9ezK9stkTD77q8mXD
         F8YAyjx7fl3jR296wGo2G4Ow5L2Vc78A3PHAB9zxySbVdw7zRRNLYuR83n3yrH5GkzSX
         djkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m53iicsreE21DbPts4Cr9sEZPT34XWA0tD1193/bxy4=;
        fh=5WAfFsZyeBQF4YhzWiwISEqgU13gyYLuZxli9Vidsw8=;
        b=H0HBCssHxkSVQkH0GBaWXSC/i/YqdgSJyMSON7beVPhBpppo2UOE3ZR2kf6OSY7ABP
         sYd7TXAIB4iwJRR5NvuOXzHNxxllShOWXqZQRU4XC7fh/d8RfcREIyZLhRD4QVPsg2MY
         pLRCJ6v/GdOP7QPPFqV/TRdR+cFvK8iIMqWLVZuuW/FdCqiF8fl/jcvjBOor2gwfAGd5
         GL1377L4pggR8aMwrSW+fdLNsQdcc4Ou8wp1JhWeCUQ58rIzNbYhVK8rDXwRBxNvgYjc
         yyaGz/4h2ceYLvd/h4F44+RSXarfK0hynRjF1hgoRtQSGJJqon3gB8gfMEzAahimx7Yy
         dVAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778705152; x=1779309952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m53iicsreE21DbPts4Cr9sEZPT34XWA0tD1193/bxy4=;
        b=vg5vQmcY8MkYh3qUqvMTbaTefsvFr+WpGIeTOoFqyxasRPLI+81EQYSEA6SgjjlTOy
         aaqkxIKP3Esx5npUavF5Wu4SRGbjxFfRTj7TpCKiZpyOhGT2O+8DWjf9wp3R2QDkupzd
         iTEqcPzyDinFAYFMmxQ86ND99A1uDFh4YssVKvCL450Fkwoy4hr5P3plv8AgNBp3gSge
         x+tVsUFUvjPoEq7PO8KuvWCBBPR1UirqdXU3tfco61OcM3wJwnrG/B2x5GKajKMww925
         jt9lkUC3NtfGMX4VReQwWX38lUV2O5Xrd2ROVgxduQhENmuL9bjpBJ9bmdjTf0BCKaX6
         1FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705152; x=1779309952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m53iicsreE21DbPts4Cr9sEZPT34XWA0tD1193/bxy4=;
        b=ZNYkcQ0sK3+J6g9vlle23Mdei/3rTYsureQrXJORLcGZiwXM4OJhjyNel2Gb9HpYe2
         pXd8mVbIzpGQ75cwLdSv2+3g3Z5MHcVaxE5gEzsPh0/mX2Y/Czk31OpoRuLu+28B0xjX
         etPGnnn8y/Xbe33VBLKzhpv/Hn/CtSbCKGSkbTwJw6HETj470DRDBZx/T6cZxerYmLC9
         fV1thH8MZFGf2jA00jhV41RYvUp06rzcqotnwsBesLf2W7/mtfdGuahD1Xow7NNmK3YM
         yuswb3ohJe8ep+SIGmJIJo004PqApCDvgUFkXYrADeYUuWZLewlnXaV5yrDtDAuPQA8u
         y0yg==
X-Forwarded-Encrypted: i=1; AFNElJ+8l5CCRCPsw2pr36Qu0vQrpcuBVhjV3iE8q2UC22iYX5WtvqtysS/V5f/LsDf1rfwtNWsN6gTgZnGqkZop@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBBenDzfbVGKvnLBYja4GnQ0LAArWd4BiJteZjoDBWLpJvKvP
	GeH3QwLh3qX3LhQgwUNY3rwskNy1jDi7zSh+F1pWZbgdKaTkKqWF3nTy0ahUqugDXTBmZQ9u77a
	KatSi6Qd/du2GCKjBczadJ61V5Qa33ECSWxA8omIh
X-Gm-Gg: Acq92OGUU36kq97mz46RgxjPfihJVFFFwrv42K1YDdws9pkVyzHSqlihfCe7LNp4iDq
	ov03TSiMt6O/qXin3ylAJmhnI5eHSU/khx780JTGh2bhBiPSymNfUeZ0/x/9V8gpIYcHOBXbX8W
	TasKiINAH0mwCT/N73i7/CyCXzzW5dLBbLiSai4gQliGEzfN8+h+ZDHt2RsRI3ZnACrQz6sFeLo
	zuk+AG5lIDxrN+fCHpgvNt3nRgeN/5eFIr2BvyBEHoJ6YSDtK4Y86HeRk2VY+0BSYddh7Jx1Mdq
	yxOm0vPdo52B3tx22J2C0TC08Q8DUKeBYKNC6/X+AVr+HOSjc3LF
X-Received: by 2002:a05:7022:b87:b0:132:83e6:1d3 with SMTP id
 a92af1059eb24-134d2ed3806mr7612c88.9.1778705151850; Wed, 13 May 2026 13:45:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512203154.754075-1-fmayle@google.com> <20260512203154.754075-2-fmayle@google.com>
 <agOWHm00w2vlh1_o@casper.infradead.org>
In-Reply-To: <agOWHm00w2vlh1_o@casper.infradead.org>
From: Frederick Mayle <fmayle@google.com>
Date: Wed, 13 May 2026 13:45:40 -0700
X-Gm-Features: AVHnY4JoNUxWMLfHqvAswksszrjv1afld6NLcRmBaT5S7_uKAQt-Obem70l4o8Y
Message-ID: <CAHCxdc41Zga60eZ+L-=6rizr1DSduaM12kGL9brxaZNPMpgKXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/readahead: add kerneldoc for read_pages
To: Matthew Wilcox <willy@infradead.org>
Cc: android-mm@google.com, kernel-team@android.com, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:05=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, May 12, 2026 at 01:31:35PM -0700, Frederick Mayle wrote:
> > Formalize one of the invariants provided by the current implementation
> > so that callers can depend on it, as discussed in [1].
>
> We don't normally write kerneldoc for static functions.  I'm not sure
> why Andrew told you to do this.  I have no objection to adding
> documentation, but I don't think it should be marked as kerneldoc.
> And if it's not kerneldoc, it doesn't have to be written in such a
> stifling style.

If it isn't a kerneldoc, I can delete the essentially redundant argument
line. Besides that, I think the stifling style might just be me. Let me
know if there is something specific you don't like.
