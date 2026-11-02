Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652793;
	b=dZZaOUfCYeolD7dp02QfYIQ+DIx8S2pMJuBKlNsHG8rtNQXZbqxLKoMQCKi4oqOUESPv
	 LqUgRLcuhQ4K1CpOmGtloK8oQ8idsESsFqiT+GFAoh4lLFfwZWxn/iPpMsnZf+BD7xDKO
	 yGjE4jH0Fia6HA679UNLuJZ6sQRkHGJBJpIpIadqro+Mhe2A+6lK1KgeD2kLEuuSzmPb8
	 prx7Kn8UrbgUViZ6EmpLBsaeuXk3uqKZx6ckKnGM71Ey4yFGwLrWunWaY6ydC+qcUWh37
	 Mp+RoOTidUtHDjjcIJN9GkrLjduiCEKjdlbBExU8RCTVFVrUyJjv4imr8/fnBddCtiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652793;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=HDDCPtVDpnnjcnfC+6JNb9LwVlUHrkevcgEyf+7RnCbp2gASX5NdkHTN5FmzQj9N803Y
	 kWIi/xUXqg76V5y1TSCPoxsOiO9wPtiofgOzBYNnBN47Cwipd14dCJf5xWoqmLF89bBIH
	 ABYLKbD3nFzVDYg40w6Wg/V2l5L+tuaE+UT5wHHZ6Q174bLMDI1bOPxeuR5B1RNolx8sZ
	 Q9dRHyqfrhx1khr8HqFRtGp5hvhDNZ5tvfEJGs+ppmaa+8/Xji+b8ohU99B5J0KlQI50E
	 2ATyXfh4AmIcyPoOYIrq238AX7oJGFfiTjewvtkdtmBLBg8h9GDRLyDfCJbBreb0P6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD0606A329
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 20:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DFD0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
	IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
	o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-vQh7ESFmNPmmHH2C9IzKgg-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: vQh7ESFmNPmmHH2C9IzKgg-1
X-Mimecast-MFC-AGG-ID: vQh7ESFmNPmmHH2C9IzKgg_1793652788
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab3061668eso242311fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652788; cv=none;
        d=google.com; s=arc-20260327;
        b=GJ6h46TzzohcgJunPXBzNZzx82qxdbu6zDTNXws3af7HB1EJRx1vbmsbeSU/7G/G5s
         B8fbU8Q9MPK19NBhTUf7aCOCm2GwLzOuE8FgcP7tVtHDB3V4CiZ7GZD/EwyELCIw/aul
         jsOpxhlOOl/POKZ7so6tIAF8D46j1joimGd1sVYw7ViaJujz1kwswnXRfKWTRF5m43QJ
         0qFJdARc4nRU0P07oWLUtU3FlCoOXFromGcuyMHW31rZkw01/Q4T4c+fMn2ikgVsrifc
         TeAK4a37hbE4vYsYNgaxAvg5Hum1Zdygg5sZP2xOp1rhjNNKsRdfczGn2e/zZVjW8719
         T6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        fh=uLRSTk+DfjT/gw4H4CCVMlhztkIphv4SW89YHHsNJVI=;
        b=KFSgDRFOSYxTGqCh90blsxyCY8b3gyNpm9T0ErqdBkOGi5UGZC23IXeoruDnXgx8M7
         tqOjp6sL4w+KLao776/+3jd3tP7mTZ9WNdIo1FW0rebyyxicNZrTYgOB0f6MJm4mU+4I
         a5AMe/qjGqENZARgJ4UIz7jSIKrwJ1yYmJ/19SQPsZEffyIZuy8KUFSyfJynfoUcNj3P
         yDQwUKGrVS547T5PcE2g+A+CU6F+Ro0u/Nwhx5/r8H9ETOvuDZUsoKPrutAtfYyc8+kp
         bLpU35Upl5lqt7ATCyAZTm8riNwqdlbxgGC1Q7bFHECoXnARxE42y3ga/6TXBArkn2E8
         CKYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793652788; x=1794257588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=ILbC3qNVxcxSfLLqiEMczm2K9EWJDHjQ3jtHiRo8lvs7xOcCBk9KViZKbMYNn3rDyD
         1nRBZKRZevJudcNGThw44x8q3rGE46+/V3Lp15cYzXfiXGQHqy3zvhO0o48B5BncA5Or
         KbQ3kcHqkQQMolwwbUP9ub3434QutGVu8nmoCGzc2PCEhLmjOocqh+8d4XwIGdidYoBZ
         1xLTej5dBNXaVOsg0H9ykUYcbsfyfY1xRAFquEOh1DF007rqhduAsvbJpJIrCtz2kQKk
         jbQ0GJtS49pjk16tDcdcdHiHPoCzeSh4Rpt4Z21PkzyRrg6RuTlgqDQLYpdpsCCp4Dam
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=iInNuj42ttqNLTNGg+TIDJnhxPvcYs3AjFBOAnxy5qgXFi9HzOPQtIgKxZizPAdVXf
         PvKre37RCYEzl1NuLwlsrSE+FFOHzZHh/VPg0xOPF23yZEhrkRFuwZo5ahz2wsIQzcQi
         JBp4F9fzINtvwQrdwfdF4bMIlsl1g8eEPZT9ZT9sRxN8hai2BV+Ai2Kf3ISFV2wzF3x9
         OjjppwqWKRAcLoBKgAUF5mKWFPhPf6uwGNAjBx1JNMll4myJVaAyaepSytNQs9ckJjFn
         RUNiRZfskyH46QrLdd8kl9w/uuHLGYqngQL1fB922K1ZrrwYY9fJHYQnXcQ6FnNR8llj
         NlCA==
X-Forwarded-Encrypted: i=1; AKwUvBxbuEIeHPRwplPRZpcBZ5oNbGli9wcv8VOjDDI3ekpXPru0KjjFjmcs0epaMIgZbUjkJREAkhL+5JP/MvF6@vger.kernel.org
X-Gm-Message-State: APuU4Z9E3LoV3Lb2iwJGNKPsIcobzSATI3CwfAIr6rCy4TJokwnoYWR/
	y1KH/MS4wC6lca5uqBQt9rY8W5pu1YgCcBxYogShrPtFoZ2CH0Z2Jt59I8Mi9LqWUI3ZZACW2ZE
	6hm1IChfb+kp5fO2r9aZK0CTUCXqoGcpwwofTedNSYt48MtbF0fe7WO4HBuQ2zuaaE4eSbESx0E
	VWcAeJM13vasL67jlXBG4ohQcrPaeMRTCC7mRzG8A8Tg==
X-Gm-Gg: AYBFou0s0fYa761jr08eR/nZjdvcPeTVv0MLTaOG9+44ViYbfQsvlLJCfnbQckybQ0/
	htgMJE3dtmQ2qtHGzgSib6IAJv86Zx1SxU+2whj9KyupQpTfOqW5QWswjjx6DwWEunfXqHvkP61
	FxSEoXKBKBpmlDkNwe/nJCJnbJv5j6jxkGMv86rOvOfu8pca3Y7ymhv9uz
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499311fa.13.1793652788273;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

