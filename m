Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4B3C415C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772002; cv=pass; b=QPiYe6+8XX2YmVwcWYVbztXJKQwroyhE5IQI7Tvjmrl5Oo9PC/4otCTx6kuWDDdVoAo4DfF/tLL2cXp9cqtZw29gk1KTgCc1HBpVmeIx4jwOw8nPManjzK80xoruXs0yxQNKObK+MxBP4gwnPqcqb2rAidb3xgJw/vrTKWVatm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772002; c=relaxed/simple;
	bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJL3tUWJZqdSTatxQvRa9wnGj4qGAaSeLqV0Sr+3TCI41VIGu4P3JFJIkHTBowtaMP8AFbUlgUNWlGDhIV8NDfLHK6yoEDNdguStTElctuDizPGt6c0LRYnZE+dfzdek9L+2qo/yGHM2xEGOCGZcXJu38UAHhWc09mw/f52buTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHFB0fSe; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHFB0fSe"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38096590070so318993a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
        d=google.com; s=arc-20260327;
        b=Do/Nvy7Xf23er7rLmHDfEYfUCTvriJA9LJEI1n98tEW5dd27Z0wlWYBkUuZu3nMJJm
         iqEp91oAup0hZkHkmp52PisoAzgLjMBS9O0U9oVHRbeG7w7DhDaFPH8z8rhT15Vn/vx/
         yg9Nuxg+l7x/2UAUehEsh1rSljSAd/oS9EOzvn+2halnbiVUKSJIgK7QQYHGfIfGx+eL
         A9dZWMfeYn/Fs7H2i11P/BV0eru8KELi6BbJnot1SLRKHkNkd/i8Et0HkIF8KZr5Fy4D
         +gs7qoVNnoo5rOsHv30fEJk8ICPebxIX/RY/tyLtSAjvXUOg91kMYvb3M8VGS8jS4TTH
         1sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        fh=IZgOruUC6l/DUMfxiKSXQ2wbm+wY5iEfA1gMwK8tJ3w=;
        b=EZz0Jk4VwLVbCYPg9oHectiQhO+dTjc44dA65L5mn7JnNEwBzGpU6m3a3EYnpZcn+q
         5+MQMfkR6Ib3agvfip9V60/56Vjvtmiy5/No6TycZZ1nh75huP8DCHMUl0hlBJt1Y0Su
         ng3/6z8MEAAT96J5hXWcy07urQ54EwVlSsblPbB07HYwznjJSyJEuayrda6bfrYQ5I1j
         Zo3nNPs5miaiO3HJp/jWG1/GZKRoewUE7GVyELOMUfN/86FqW0NJf+Fq1gAlkNzez0kp
         +Nr1SMbhUb7vt7Gke8mwOoCAZuXXc9M+5Qqcl+oBg08A/IXSPoTdQE5w56hl79fFpp8p
         Gl9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=gHFB0fSemSn6s4jVp/EuBtir/qlPGO8Vq2wg3sOO56WQSEm3m1wgLV+PH+YCzCwe4w
         40XUJ8N3llKffVv3KvwlpEx0PwjFhEP4ejwfKckXHhOrs4COlZYMuCDJVCD700HVWfby
         Wef44AYzEvkwlRh4pmvCSPrnSSb+EuoMS7xAp1fqanhd4vgQUbVFs9DMhr/aX2ve4EZi
         XKK9VbugY1ax8izR6ls1BpqL9Fr7yUJMtkts2rZtlWUvAdEs5tvYZoRcRU9pXB0Y6W76
         RQw5PmUpYS6rrCfKNmEtUvADgYNWM7gb8xCEbJGzjwstKv7ju7GWWD5f6bQVByQhgD9b
         Verg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771999; x=1784376799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=nyYGQG/SneGPzizze5r6I8QMMTsFOuLtHyqEeEtuxEnAM3qXC2MhvJqtyTWOnOK2RE
         UmwvcWW18ZulWK7raMv680szfuC6uuxcB3S9n4B8+sxXtJWX4fG7KfvVUy7AJsEnnWbu
         9jjM9J6u1nYxto10xz0zXi/OWLzMmuEm6bZyBUYOOmhBKDp3f+hpZn7ED7CbXKG1/8th
         ZOf80yeFrDgSG4bfUbSscyvOQCSIAAR7cF80Pvpw2VNIauLB8sP3XdEZDy7Jn8lGeOJ8
         CA/uqpT+Zvlq9s3FeSgDS7POb2+zlgxXqZ7/rMaZVLikG+yXpV5u3SiTT2BzhFbCrZ/z
         rIZA==
X-Forwarded-Encrypted: i=1; AHgh+RpLL3wPQdckj+hRF3IQYBVat5JZQi3ZSMfe7Nit6b+zGvr09hEn4cf3WP5w1PPOVB7bBZBlOSqWXjwqgcdO@vger.kernel.org
X-Gm-Message-State: AOJu0YzZarQn67Gq6+E+XY6Fl+elLF4Gft82jJKvIkRbBczc2+CPqYvJ
	zUObqVrJMlKRBKFKuURO/zl1Jj9vknkn73dYpDlyrCyD+Yt9OOK/fvEBfxCxmqc9ud20CIaOOWW
	dBwWKKFD1g/uNpa4C2Pu78IJBHSi896U=
X-Gm-Gg: AfdE7cn6b6/K+LqXQh6wGk70MR4SDd7u+0ggp6DORqEG5Vwu0bVSlafexAzFRcWmdzL
	SaJQPFoUs/QWxuvIzRRGu4lgYp3lB5rmiPESOWiXRom/lDdTz4XHPVAoBf5RHqrNMdId7mA+kuy
	8Nvvs91MQvXs2sEefWQUjLA+dRDC1FwypQrY4+BHn6x+wksCLrrDFWBFflkliGaHa26aiaSBHO+
	SNGAFq0vAhNdD6XLi1O45QQxabhELeNRBQw/tae5Zb5Nn0OP6bg6BcLE7zQdcqhVZLV3ulldFXO
	NXnGHtu3DjBSbnehcL87lT3QGSxwir8SrLKHR15WKwKdh7HMbz/d5Lof47JLJ2pHn6m69fQjXIt
	90eVc5E40Hxq8
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com> <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
	kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
	rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
	daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
	tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
	linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
	yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
	gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
	arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
