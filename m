Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24147278F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628644; cv=none; b=i9oGnWUSBdRfTu6a15hoIWsFtefm4NFBs8KjhpXJW3/ju+GQw8Xy7D6k30WZyz2yEzpSghuPSJSUwxwnY2GaSKJgdMWZMA8hZb26HFXtbhky7cd7ZsUw/Fw1+zcIKftzimMXYKEDzR+o1e6MjjfH2Ptu8iZPKF1PnA+NvbpYa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628644; c=relaxed/simple;
	bh=bbe/dwCyr6PoH2DBwgIM/qML8WXpUjsLo53+UYCd8Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHgvwCO+bhBNe9yH+vQSi/m8ZxV+OrqWVG1jVwPyqrf5A1YdWj3ITqf0J0dcKR8XRx5a0fFUElL3t/6X/8fu2wHgKhOig5DQu6VwCmX40OnaO5elL0DNBvCqwRDpWHXT0gif5iUDLaKzjMHfR7DIiaDIAs1cSUmQCIrn4mjf5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh9X8giH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh9X8giH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A401F00ACA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628641;
	bh=bbe/dwCyr6PoH2DBwgIM/qML8WXpUjsLo53+UYCd8Ew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gh9X8giHvOLqZ/eV+94cesAsIRMlOjTDTG1OHRaIFcHSPjHUYMqMObSKo0mfq3fKh
	 iiqisORQGbdWLdzOzdW5720BdKSNaF+kqjTHXaSj4CZCPZZHc7KgDCtRK0RIT641L8
	 knCnVFU62TvqtOQITjQ78Q7EpEP51oFZ7/nJUKFkPJp/Aw8iMROddJMs6R1ThB9kA9
	 QAmyptcuBMmalG+AWGMyhW/vbMUlHe1o2klAP61beRNoAPVQBjZ/DGRtYoqRkAlmOr
	 zKT98g9l1LnDgjNGKCXJox8Cd88WylIkIlboCBCcDnm2Hiap14EFIXPKw1sVt9Qk6I
	 LpjpqrDFOlHfg==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6685483aad2so2187511d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:10:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoTAn3ScrgXT411x3utStwDOYlMc5WVsLzOxwJtpY5rIVSbfbELqHcHmYHUbJgqUB8CKzhS8fjWLcQ/xeNj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SK0Xs6qD9oR+V0xoHI0508d+5neJNfM233IrVcwDXmKU1EvM
	WoVzPojw3tWWdBMcP0I+TlxPBb9rU0AEj4kZSe1v3vgZ1zn0j0sL3hjkQWhAooO3Q0B+r4mdSLi
	tpmrwlgaSKhEaoCOmMBg2P2N7GQBFcOU=
X-Received: by 2002:a53:c6c1:0:b0:667:8b91:2418 with SMTP id
 956f58d0204a3-6683bdb3e60mr3375137d50.95.1784628641072; Tue, 21 Jul 2026
 03:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260720210202.1163861-18-joannelkoong@gmail.com>
In-Reply-To: <20260720210202.1163861-18-joannelkoong@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Jul 2026 19:10:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9_v5V6tLp7weMKmV93Z_Ktoz09aBuLFu2fTh4vF2jGoA@mail.gmail.com>
X-Gm-Features: AUfX_myYICVL8mL56WX0uC4X8YB0o3yCLA_V6zi_0eVl2eTeuyKXxdnxOZtBOdg
Message-ID: <CAKYAXd9_v5V6tLp7weMKmV93Z_Ktoz09aBuLFu2fTh4vF2jGoA@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] exfat: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:02=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Convert exfat iomap_ops to the new ->iomap_next() callback. Each
> callback is generated with the DEFINE_IOMAP_ITER_NEXT() and
> DEFINE_IOMAP_ITER_NEXT_END() macros, which wrap the iomap_iter_next()
> helper to finish the previous mapping if needed and produce the next
> one. No functional changes are intended.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
