Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CF43F4DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519590; cv=fail; b=LtGjlLzJJmt3EV+0skWh1AcEaUiQvpoNvVcU/H9uuTv7gHOis9RpLeQGBY4UHTTavPhSwjYxO2IIZhD1cfYOHMmIh2Uj5RzLhcAM3qVu3lRlmVsTj1JNeHViOe9rp4AKZx4Q9sLpLSugR/u0mfOzcE0DYSzNcmuqmhVevWKIgpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519590; c=relaxed/simple;
	bh=r6qkoDFD72aNqg7YZ/TcrCwk9wBfbwfACZvk0C3Ml6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUuiwCuSUKZt69fZsYOjiC8Fh+6G0VRzcF9CUIUlkNUjJFCqN4d/6juf5tP509Zs7FuBTC0NhlelAO2PtjehFYNSwDE9O0XoeCS3neAeivFXlw4qc5Rc/Kn9j1v+UdcGgh8VufjUaSLyiZAJz2Nz/8FYaKYlq0JFnSlx6IiM35Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=lE8Z2gv7; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=R7F3XTsL; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="lE8Z2gv7";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="R7F3XTsL"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1whSur-00000009bPQ-0cPE
 	for linux-fsdevel@vger.kernel.org;
 	Wed, 08 Jul 2026 10:06:21 -0400
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aeba7dc09cso600803e87.1
         for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 07:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519580; cv=none;
         d=google.com; s=arc-20260327;
         b=NfMsU4I6MB789Rz6GnfUYsOhUjzdqs8l4D2j1q3l01cHzdiv5NMNLp/u8ZFuI4eEdW
          vY7Rvk6a9cCDc2WAv04BoSZ6cQyrJM8iyNiVMP+GGqz5AWAJmOk7JN6oPOqPZD2/FZGt
          KELyDuZxhfDksQqJUOYrwv/7aokaXpEohdyVbQY/FX2Xb0XP2TjaNiTTQVY+QWqKcNxj
          hJ4o37ZnuPvFHl1slggt3UjxmT9CjwMULaXv0R8wESaHSXvPuOlLJ9Weg5UKWIgOFSoq
          cfoZWbIgE8O1b+PIeplV8+bIE8mQyBqvFjlcTgXdkbN5a/yz2zqVNbV1aghxE8xKtNwf
          sH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         fh=fyjMTqX+gj0ZyWswys20/zMTrCaoNwLjPRpq3Px8mxU=;
         b=ESfdN1OW3bleVI4Gb4DZEJXjfi2HVpThyFG05ss+YU4FXZdqDvhexssTVq4kpXLzf8
          dngWULBc0F8fk957Qygnu5p6cquKYgU0pJV+FcXu6DeGADZRZHGd1/J36GDtEUGWpXa+
          kn0tMBWqDwmJicc1Ukwikm5NYKgfIqfC3+Tz3ItIlC5BOwIxfLqQgejorOqsj5U/k/T/
          j5XplBSXAT4DfAzExd7JNyOeFXa3LwlGb2hhJa6kvA8QeZDjeGIRlQKQWMy/HNaH51fS
          cZWN7td44QRYL3CVCBleV+iOy+LAkYunsqv5cwcw99gwgMd94OfsaB45oKYqSApXYNWA
          Gzmg==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1783519580; x=1784124380; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         b=lE8Z2gv7oj5Ovk3l/pFTmLrZRpu7sQE2mBQhJe7OcfbAg1B6TTeRF/zoF2s4ydpLxD
          SB8oCZAtyz1M8fdaHpfyG5vADe3FuhNqQCXfqK9Bmwzij63hcrnEADZJtg8xsjlz6Em/
          n8YnZSkFaj67oW1KJ9m8X7sptrgvwQB5igpf4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783519582;
  bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=R7F3XTsLVilWOG5j51JgnNa4E1RW7g7V5i5n+KyWK1lC+JwddXhuqDtExr13RgPjY
  2djTLbL1jIhcrloBUo1SSKYFs9YyZrVjr9wWmXR+51u7CnOQpcUcFliA5vRZkhKfri
  kFmvPx3nKp30YQjYohLinCkG6uM54x6wfmTu+2+Q4gPddPeB/R+3iMfRd+2MSIhwN/
  Ja3Tu6WFm0ZB7Ii/4bS16cp0NopsOIGva81VaZS11GdjAiWYT02BJA39W8yYk661Fx
  cJovsgdpkQvGiWJyuFnLc5vdGdO+lT32pVMiCfCPZnQQQKU4h23TrafbSzeeyUUsBn
  otr1wHt6V6Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1783519580; x=1784124380;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         b=NvuHbuTVyuWpNAb7BSuWF2wJnR2GVtNQZ17q78hJokGp0oEoCPgHIeHmeUOn4ggad+
          L/XdppwSg81yiXcIvLtSGR9qvkcaHfoB4gsrS4SEDxB0jFjdsHHCk7+lgSwXTE2njbNg
          e+1CBr2Y3iMg+Hr4XDErWL54ax0y/86A7D8rjCeVGyJv7YaM3zQON248gu0CegfrlZbq
          kjXsAF4Ef85z13CZ/211oDgyPohooqbyWITYkVF1JwpqEGD8qCzI7QGnYe0kt5SD8qDx
          WuXp4+B9M3FkM0NvWZ//lb/bFxbEMsoIkt5l+2/i0lybFxTKYWOlscqy+GXS8sn73X1t
          GMdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaCXnUCnOZhtl7zQKfcav5aJshqnyUBDBffaIB0sSCy1LbemEl2DbBD9VGuyPcBWTf+G5GN3FwWWHtfsYZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyodzLNXp6a5FlPVwCuxD6MNY2+IA/Dd41t7aa9L8Uf6Bb01XS
 	Xtk+Ef/Mq8MFXJMoUwZ9AswsqweaFlW7+xBOT6cTzYbZLsTAjvigU29goUsozqym5PXnorhEk7W
 	WlR1tQutrr+AEksosno8B+oTsmCv3kMHBaaFR9dZ2K/52y0VmMHxjUvUVP36lSKyjGdJP1iyhG0
 	EFWJwSj9B34kxJ0xW+VHcXTZ3EoH+xH6cRtkW6wZDs
X-Gm-Gg: AfdE7ck1qRFqGphWpAhGkzP0xrykMlgtc+OXQbuhveAI/c3KzULLTT8Q3jdEuJnByuz
 	9I2MjKgfxCiCRECc74e+qDeOb/4q8dAdbzUR65lQsLPgaDXuOd2Gk8Ou3dYWVb5D2gRQdT6FLoQ
 	RDEc1EZxsu6zvki/+H2ArE3GfE2qZLuXNCaN8h2UQVf92mxoDjfAUFTnbWMCacf572Mqo=
X-Received: by 2002:a05:6512:340b:b0:5b0:11cc:2284 with SMTP id 2adb3069b0e04-5b011cc2571mr701633e87.21.1783519580564;
         Wed, 08 Jul 2026 07:06:20 -0700 (PDT)
X-Received: by 2002:a05:6512:340b:b0:5b0:11cc:2284 with SMTP id
  2adb3069b0e04-5b011cc2571mr701620e87.21.1783519580206; Wed, 08 Jul 2026
  07:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702165409.164568-1-pfalcato@suse.de> <akhYu66GmjyM8l6a@casper.infradead.org>
In-Reply-To: <akhYu66GmjyM8l6a@casper.infradead.org>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Wed, 8 Jul 2026 10:05:43 -0400
X-Gm-Features: AVVi8CeMh2pp3lqKg47ZNV-_AiaErtleKM17gc2gMeTGtO_5NCmQTr7BfEwc8Wc
Message-ID: <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
 	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
 	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
 	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there, just checking on the next steps here.

@Pedro Falcato Are you currently working on this patch (mentioned
above, re: holding invalidate lock), or are we perhaps stalled on
something?

Thanks!

On Fri, Jul 3, 2026 at 8:50=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Jul 02, 2026 at 05:54:09PM +0100, Pedro Falcato wrote:
> > +++ b/mm/khugepaged.c
> > @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm=
_struct *mm, unsigned long addr,
> >               goto xa_unlocked;
> >       }
> >
> > -     if (!is_shmem) {
> > +xa_locked:
> > +     xas_unlock_irq(&xas);
> > +xa_unlocked:
>
> Hmm.  Before this patch, we increment nr_thps while holding the i_pages
> lock.  Now we aren't holding it, but we are holding the invalidate lock.
> Can you put something in the commit message that notes this change and
> argues that it's totally fine actually?
>
> You were good enough to not point out that my suggestion of calling
> write_and_wait in the existing !is_shmem condition would result in
> sleeping with a spinlock held.  Silly me ;-)
>
