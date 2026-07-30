Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507533BFE5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445170; cv=pass; b=dpoy+9kyccFRYFM++ObhcIKVQB4t88t8kywTC9DWiBinj0BZfkwJFqwxrWullOzC1txtrG6xDRIKkljbvrk13nWj/hQqY2Q9hXSOli/0wcBdaOkuP+bUQRY8tbuKP0VBVKG3wXLU8kr5B25p8S1qFQ27YymvhpHTvq/ttMDufsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445170; c=relaxed/simple;
	bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5gRv1Ei2PfPrJ12qambXyCpPAPetr0oTfRkH2+M38Q2WSA2LornTEkSopxfCYNpTxJP05pMDMQJq/hWyZN76/6yIXsJDF8kWokJUarh5inzeAo8uERkGLaAeRIxV8Hna6/zhCFsZyZ2wK2nOxe0jApsUp4X4XiaC55aw1Kf/1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6ME+3Hp; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ME+3Hp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49550ec592cso7807595e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785445166; cv=none;
        d=google.com; s=arc-20260327;
        b=Yw9iX5fv1Y0/9Jjer/wkoRgIiSsR9j579Tjcbf+Xge/CClITxDuvLTMBICs7XgNFFF
         /MLeyEz3GWF/PHb3JKJ9vszSv73f87bj7Udnm9k5Y+lxn5hHTKL5K7zemviORt3EMIUF
         SO55Cgcu+aK5ZCa7rOAFJvkBvcJZnxIutyq1xLCLWahAjQGKBw7T7TYigP/1OoSPO/qD
         uJOfkDnifQnFCBiCj5l22Jx/NnjjR8Cfh3IaatSQDrztrZN4adaFOG1RNSGVG89kgWEo
         Bpfk4AeqFaSWjpe89utRN26keIxIngEdCCNwAOKedKwUlHyV5Wp13xlA5PLFqSsxPehO
         F09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        fh=V9ovtE8J2g75g0McciJ/k5sNfhlyTLuT0zOA5F0ZajY=;
        b=b0rhfetQT0mQUjPZJEiCXmBe+8DmXRJ8GUgxkRWXGjP+tjR8sWZRd5Abl7+JVnBgOI
         Jkr22DnBCbEOJ4HPPK3G5iiv/MSdO9RotNIpyI6qWX8dEmzFk9UfWCuffucAHI7CJJTK
         O7BsMFsMpcxdXl+LQF4Pt2UGMXq26bFQHgM8M4NEEidqX1EBny2rKI2mYezmn+YS2qtF
         dOyyVqhEBPJkg/ccmfNW+8VZiQk3KNeNWJ9Vtyl00wS7DXUUsIb++pwNQENT9tatR2O3
         9gtdZA+lozjfyRJy/0hBmcWSavMoXHAnpIYR6nhus5+ksW78IHl/ft8/JJYfK8O47RQD
         q3uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785445166; x=1786049966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        b=R6ME+3HpvtKodB5vMz0HHdPy/tumwxk9eembr/QeHJJMiqq+apXcoGz7XZc43ETGd7
         O8NIVDm2Uxanw1UE2eD+0O6cByz3cIg34hczcsHbkvyM4zMxOkRF+fp7e6HFxiNdCyqF
         mlDU0nwiZkucLp2N0Mksf4zxO7W904kuFt8Dk8kGpRmilj+cy3+4PHQh1OhUMuGiFXjH
         LVPVUCNwrKaIJpSsIFW7XOikTaCgZK6wmtyrpJOGyMzx7KefmrsTEXonBIYS7Z+D6ogI
         lFvfmp6EKz8kYmHwGulCC68bCuCe8OV5dmzEtsXeIYAn2CF5fWeClCLjySPRlu4hEX9r
         mr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445166; x=1786049966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        b=oHpW4AbUs91UWXUWkndE7NhfVB6cY3jn4JYPGsM1qTaNDbnoGGVEDI+XbQvC0heXbr
         Ox16QC7i6XXfVUEylWOwDfSv783WeMRGP1CPJOZI5daGsrfLGvsq4OInD7epHLqc/naG
         QpZjXsKe2Ekb4qw/Y4rwbZqv2C7LV0M9oDBp8Sx5NExgh73mAPzeslh7zVivyKJuKIN2
         zs7lyRROhmvWG59Y7NpiegBd1qxWdbzGbzDWeBSN6C1k7An0g1SYNfwi8yeKsVGlxpmH
         XTNCryFKlPJjh0e1Q9bIqJZhFfW9vzbgKtFMx0JMheNe9D/UIDwOIVojVI2tJJo2lZAz
         D7ow==
X-Forwarded-Encrypted: i=1; AHgh+RpdZMV1g6WEMrfBHdE6HCgL4IDw3sowVex99Qb9Es46S7FlbTHNF+yHy5sMF+gzWXUkXbMKp/BCy4jQ4Qug@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTSOi35+HwyLelOqRaB1xtj/XjMVrIgADjpNDnWlrJ1XSegOF
	5ols4j3wW9EqZyjdKpN835hQs5AB4c8t3g+jTt+OtZD4NLbzQfLJ+fk0q4ngf8qV+v3wiJJzgFZ
	4yU071cnGvSJxtMCdMVUVD1EnhdBOF8o=
X-Gm-Gg: AR+sD12/rJ/EnL+cheXT0R2Fb5gZaU/EsXbdmL6ue+MYrnyIizSQUeuHgwOyMO7/BXW
	6Rn/Az9UQ7N9IBaDcPd9/dGD95prGXtsWjyANDrBc6HhfpLfZ9Zt64GUkDHqhXYJirWyMpecvDb
	CoanmLU8B+w38nIv7ScFSfNGd+8EPFknl+N/oE6jm2lRUa3xueI7l1/ksompwmJpSXzF6dzH8A8
	iSCcSMAamrTEAll9ZgDQSdrkKKVNHB75MII0H44VypIY7OcvM1UaTu6hxle1TFC3f9ZCDk3xs48
	gZO2+vde8bVyP/nJT2atmIkIwLu5YxYI+f78SiEJwnTm7mpt1DnxZJpkre/HJ5q4uOCAz8qDEsv
	GWH9RXSEwRjrKNFMlQIP85yiK
X-Received: by 2002:a05:600c:5641:b0:495:50b6:5a6d with SMTP id
 5b1f17b1804b1-49804c4cc7bmr22571485e9.12.1785445166339; Thu, 30 Jul 2026
 13:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
 <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
 <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
 <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com> <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
In-Reply-To: <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Jul 2026 13:59:14 -0700
X-Gm-Features: AUfX_myiGnqGNN965xypoyGuHF_KvdnF6l6Z1HdJgtyCUEVPa6_UpbiR6bYul1c
Message-ID: <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> As I understand it, the merge window for 7.3 closes at the end of
> August. Just to summarize, the only things needed to get this into 7.3
> (besides addressing the Sashiko comments) are:
> a) replace FUSE_GET_FMAP with FUSE_NOTIFY_EXTENT_MAP (will also be
> good for famfs in general, saves an extra context switch)
> b) remove FUSE_DEV_IOC_DAXDEV_OPEN and reuse existing
> FUSE_DEV_IOC_BACKING_OPEN (logic for this already supplied in Miklos's
> patch in [1])
> c) remove "config FUSE_FAMFS_DAX"
> d) remove FUSE_DAX_FMAP capability (not 100% sure about this, but
> since the only thing added to the uapi is a new notif type, seems fine
> to exclude this cap flag)
>

John, is your intention still to get this into 7.3 through fuse? If so
and if you're pressed for time, I'm happy to take on the items as
follow-up patches to your series, if that would be helpful.

Thanks,
Joanne
