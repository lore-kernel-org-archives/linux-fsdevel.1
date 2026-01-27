Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B236A03A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539579; cv=none; b=LzhoFEGZRF/mGlDvgcU1LdLc7YxUtJa4CQOWLROTHD9aGS6GaSXpwf7rdba9sKvnEdSsRS9ljGq9doa1b1A7EwLOip5xkH/0ORRFg3gkuQn1hhz7PVtsRsVh3g64zX2yK5VaIXWsaVwBGRd5frIhTLlrpYINSi8vdQNeCZUSZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539579; c=relaxed/simple;
	bh=Puce/Y2uoOhkmXAnyMr90G2Ehk1ZPgymehgrzrUE1uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfhfhDWw0Tc0ZK4IXRBWGnroPZcfugB7UaoBdJ43JCxlU8InNSJ36LAJTGEl0u9qifTKVu3C3fICnIAqVOJi/0Of6HDl8rPY4mAyAQMgWQ3teSozkbd16uahX0lYO5SUb7iqEbE886ubIgNpHoUDXNCzklBOv7nAM4CJhJ3JC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euV4UMv0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euV4UMv0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b6f267721so5702957e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769539576; x=1770144376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=euV4UMv0hTturAXRqW3Enjalcu4vo6X7E7SRzytQhQm/8HtcPHjIpn8fIVjkr/+082
         lC5dno3zKt+BCBQZ94noh9gkiZqQOgPoMyqh3tzfKpzv7IS+7DPTw3mjdyCZaem/Lx8H
         iObm/srDQQCpb1AMN9/5LlJmwVzIKe6guD94Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539576; x=1770144376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=kRyFOocKpf0l0q9gaobBquTwnXo4NJx7twFjrHENzmz63dTTsEpTaFhlrYnUNQp+aq
         tEuG+9FmalXfkvX2mbnAhAQkeN0kQpwW4D0ibR+rL9NdMk2mRFswpHRz72eBZOfVDkjo
         X5sOcZdrK76tkI2Y4kGFWWOOOx6NuAj6PzcVGBBm8sUWKC8r6Go2dXfva+Md9XnqIR2H
         t2T93gyMden9m+vg3v7ItYSw9oppzPFtuTW6NGlK3v9JKZTqxW1XyZ1Q3K5aNwomAhAP
         6U04SWHpBQuwrLus+GRrCr0qfRKjz4/IAxEdknvZGVmtSMbNRB3bcLMgoBEg/VFiWW1q
         DOGA==
X-Forwarded-Encrypted: i=1; AJvYcCX1URAu3WQUdTeB6sKo28GbhievUSIA/QaXPOnSfF23hLZZqgEVBaXnajvIe+HeS6i4GYZIN9gQ1WazO43D@vger.kernel.org
X-Gm-Message-State: AOJu0YxaswOPQmy3dyALSWHr1xt0DnMd1bJyKx+l0ih+/Xlskeq0inE4
	whg+KqrfYFYPOpcIiDohg/8sxfggsxyAmRz+2Z5jTlrWYwa3rhCDXTyCf0HDuB/HDULTujKZKrV
	hYl0+3Uw=
X-Gm-Gg: AZuq6aKiVqRdryySZJU6aNDyYJVV++6xqE3yLyWaPHUY6lXiH6t2GssQsoFfCX235Rt
	y2/fk3o1wfZ9lMD+QJI7n4pCXjXZg0+A12PSGNLK5nfLlOruyaZdKXwfS7k3NZIJNZ5x3hYwdqX
	h/zb6Et6pnz7g+oiiCxwoyl11QNhEWXkH0glaOO3zSRPB3NZa0i05HiBF8WQT2evj324uh0Y5Pj
	2HFZidauaA8P6lYRCRB7yBPzOJvlwdaT6fOag2h9E2FReVXdkljmEoAwdwa3xQCEhq5ZnnHXcDp
	uy2rwnqUb9vMai/W/PaoYNNAK0KCDtadDOJCyuMDV0eeD7Wf527g+b0hpDkUgwvWdDkdkuRu16X
	V+A4bRwS/qeIL4iHwT+u3cplV9Euu3l3cupcNovRJHybVKPkYp19AfwaYcYuGWkYnTpR5nEdA+i
	AIXWfXd02efpUUfGbs0VG/wP7V1WU7BLACsOtLEDlfh7OuNjc/XmVfmB+bX/6mcHz3
X-Received: by 2002:a05:6512:2393:b0:59d:f5a8:276 with SMTP id 2adb3069b0e04-59e04017116mr1134862e87.19.1769539575600;
        Tue, 27 Jan 2026 10:46:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074ab98bsm93556e87.6.2026.01.27.10.46.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:46:15 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso52291171fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:46:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9gL1rnKe2gqR2GgFKn8CqO1Zvo85vMenaV/09sDDC9zawz7ytygayl8KFu7lTNiEJMR6qKfyGiwSUX62C@vger.kernel.org
X-Received: by 2002:a05:6402:27c6:b0:64b:9d9b:f0f7 with SMTP id
 4fb4d7f45d1cf-658a60c5513mr1939607a12.33.1769539160812; Tue, 27 Jan 2026
 10:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com> <2026012715-mantra-pope-9431@gregkh>
In-Reply-To: <2026012715-mantra-pope-9431@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Jan 2026 10:39:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
X-Gm-Features: AZwV_QjTvEFSmpHcnOP1NJLVZBe5xlcj-dD5ZtjcNC__rjqudIVF0E_rBxSpQA4
Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> open/removal races") from the stable backports, as it was causing issues
> on the pixel devices it got backported to.  So perhaps look there?

Hmm. That commit is obviously still upstream, do we understand why it
caused problems in the backports?

                 Linus
