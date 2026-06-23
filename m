Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28337756A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210291; cv=pass; b=Wzv8cdsjeNYn7L/uXkFDx7Q6c85wpg8mef1Xqqp3XZXGeeGblL8tI1617u8u8Wgfu3OoxoqVKK9ATNSOO54QvmUudA0fkQz7kVFYI+4Vq9i/a5T3v65DtNUyG4uzlV2l0yo/H4rfSwzDK7mISUiMmsdBt4Hm0ooqM/W7kPKps4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210291; c=relaxed/simple;
	bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwV3YrSoPxR6teLMfOtRA/T6UloVRXWDTCnoowPHBCqTEJKvbq8hEPD9BUjXeBHElswEDcaUZ7ybsKeN41DS3hdO9xLYJzmlPUifWtyj7MlC9L3JceSuBDMfv2nF90Y3icVczSNok4IQ6Dnn0hnDf9XdqG35jAHvIOQz+iV/ktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMESXyeN; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMESXyeN"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137dd3b29d5so87372c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 03:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782210289; cv=none;
        d=google.com; s=arc-20240605;
        b=lWlapm0srRsVOZ1FVM1uL146yjCncTPINMCO9gqk7AOluvbZWj+lbJNF62FZ6jq7NU
         N6rtH2e0232B9eQo6InedpzUllEyzoI/ZXrCkk/C2mtQwjeCy12TDKFICL3ofHgOdqQa
         yzCTnvBJn5gRaT+WfV3aRxjydKKqiNY2LHZ0/PMB4x9BQzRnAx/wg/WHwp69aXUIQjy4
         62iTiXamKFyT4UFVndKvTed3g95RTyZh0d+IKW/eqFC69F7Yp48thIyDaya4B1clprBx
         2NMtMj45BBiv8aXZiCl+Eswav/Tp7QVDODrJq/d1iteomosg8YY1IZSjDUpAYu5MUfE3
         W9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        fh=MGl3BZj+uOaWrj5UTlHXkAFwhivA2VjoSTbaH2wZGec=;
        b=C35qAzBiYDIg/EgcH4XblrJsvuGpemAWCGXWpNOCFDoPag8arBC6UcupiX2ErFp57F
         4x1x3Gux4p4EMkSshQQ6ENxaXCL1YXUSrN0Zw0vcg1u3kQevWVr8sVVi3bdlG76rtsE8
         uKjRQh79xsIXSFbCyA3Pg+BvrDOvs7jPlv5MLB2Zt+Weaj7ToVKbhSbVbavI+39LZO1+
         Vc94Cf39hHwpwb3JJ4V6ngTYsm2Ikdth0eTvHzwCg3WbJzdi4NvKVdYuNLodn4jOkFhr
         KOs/QaBjjE+N/BCVRjMKwL2z6gy2SKyvHZe0Z1PYikWU5tC5h/RBm2/ClpzVspucK1y6
         t98Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782210289; x=1782815089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        b=bMESXyeNF0Zp/XsKh3MwjSJhwW5ULG0eYUYI8gxlbpLxVlc6AvWtovnjDAzztENYCK
         YkO9Zz4jr1nXkKvC2V8xXXotlKuQITNJQKjmP+GbFkTV5HPk2eDAK+gcDphC/Bzd5eHk
         uvH2pSck5hk2TScke8/Px6+Xz1LGEGjUda1fuxwiJzwUmWWBTPgu33Q2jE/qOycfFbhs
         yRpkp4QvHDXOfk3XvOzP1LQsYwrRrdCJCg45TpMqcJO2CQ9SiX1Z1CZxBJvl4+6nTELk
         RC43psHYYDCAD41DGmmtw+TzvVnacBT2drD70QuGuXHQMgEj1HlOe/sJHWX5Ch0k/e0U
         BGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782210289; x=1782815089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        b=m9XrSH58rTQik1JCi04YWOStYdZrJxTazcg634nOLAq3cThjFD0PsqCdRnwdJDqVqI
         lqEu1+wqFRmmFpz4Ne4zfO4O+vQjvpzLp6frnha07kYC2cpxcYGBsRZRMjE+Mr5WIcFR
         EzKPZdJiuAu9nc7jj20YW53P5AqxqBTZ7R5usNUzWdGTGE+JF3paPrqbAnkQWMjX4OBa
         ER2AAFbT4OL+0/TbN95qnjLFJxBbjVP5ST7xlum8ghLfLgfoC5aBwL5NJwhHbHOo7cpy
         FWsRFlpKv+QwgONvBfDmGl686mGuyItr27hOK2P8CBN3n5kfMb9bItwk1BLBO3jFHvsz
         33cw==
X-Forwarded-Encrypted: i=1; AHgh+Rpb6sLR6bOM/fxttmi//fG7AhzhiQWQ2IqGHtaeUzG3YJKwy7TYi6hr0WH4Ha4HznTLIL8mcRvflmL0JBrz@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkdkOEIjVQGZbXmn3tbdhf9CkFFTEDefelEjInzL1rFs67PsU
	Ah8/VjJxc8q0EGMIThtijxT54GUDa/5cFxhOYZwcKP1Hvi7PBzR/KRJytvB5Npd+hX9668iIytM
	Bnc8iRGZ6EmaovNW28wEBTp0DNYgpzEY=
X-Gm-Gg: AfdE7cl1vGTD1vsZK3+4/sbevn9ZSVU5XSSecV4wji3OHivYiref2SHsg0I/V4EboCT
	/auRGkMs08ZWgNG9Hi7SHL/zPFWWEYMnZVsi/gvqLMwvKjFRYOnob/wUTpwskNP2go7hV5SSTPK
	ONS9l7a0ee81GqbFlfidOumBOyNhnOgqUAFjByEtE+DbpOICTGf2/lpyCs2N8Uuk2K2/SzReYmZ
	CZ9Pup6F34et1FII5CuXTejd+cCVaNDOkTwrZCDmsKgc7/0cn3dnpW12M1BG/2xCo8BSaiYkwiO
	14dAFHyI3XpWewm8CyNDV5j/Iiu7FLaeHv5xyMBBK/aOphYRaZswbSkH3v1zixeHDwA84P7wOTA
	atXIuGYBQZE9V
X-Received: by 2002:a05:7300:7494:b0:30c:52ab:806 with SMTP id
 5a478bee46e88-30c52ab0c05mr1446569eec.4.1782210289441; Tue, 23 Jun 2026
 03:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173250.411377-2-phasta@kernel.org> <20260622173250.411377-3-phasta@kernel.org>
 <ajpJmjTST-Hoxutb@pedro-suse.lan> <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
In-Reply-To: <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jun 2026 12:24:35 +0200
X-Gm-Features: AVVi8Cc8Kh7AOr5aHxP44CbB_NUQ2aQAJElI3bwSmo3owcnjAf5xJcUIaFT10lM
Message-ID: <CANiq72knGU+PUCXUATOkA7225++0nvALNByoJa8gaV_EuyHx6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
To: phasta@kernel.org, Gary Guo <gary@garyguo.net>
Cc: Pedro Falcato <pfalcato@suse.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> But it would be interesting to know more about how in general Rust's
> unsafe comments are related to problems beyond UAF issues, and to what
> degree we want to document context requirements.

I am confused by the UAF there. Did you mean UB?

Rust's `unsafe` is about way more than just use-after-free -- it is
about all potential undefined behavior.

At the same time, it is not about merely "dangerous" things.

If you cannot possibly cause UB, then it is not in scope. Otherwise,
it is very much in scope and the safety preconditions/requirements
need to be clearly documented (`# Safety`) or justified (`//
SAFETY:`).

Now, sometimes it may not make a lot of sense to duplicate a ton of
information, so sometimes we lift text to the Rust module docs and
refer to it; and sometimes it may also make more sense to refer to
external docs. One way or another, the goal is to document the
requirements and what is going on as clearly as possible.

Cheers,
Miguel
