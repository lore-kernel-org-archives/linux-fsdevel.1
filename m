Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC91D5ADE
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167989; cv=none; b=dMsTTRESFK1VAXuIYv08idQMAJQlkAZVjWP7W9ZtEn1tjINOZhi5kIRmwBV1EwwA+k8W9BPY+NyXoi1oHvuggfRFOOd0Cav+jOG/VX2yrzRAAfsiHJeAyYNt3eB69XPnwzWMSJTHKfz0BBFKXqf1N/0CtBxfAJVB0c01NOJtOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167989; c=relaxed/simple;
	bh=0vuWYRymkMntx0aXaCiKaanfwjhaE4A4kHzaSva3vxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6tLUpepIXsTFbIRRDqI/0iruvlYrOkKq6xFw41WLT73pxA7iOY3B/325F9GerK9JMKt191poDZSo7M6Z2GXC8/fO83flpV2x+SRVvt54esqGbJYAJtmFPBPQGgbuMUgJH9zsMQj79Cow1OUhECeNa0eWo3H9ZNbIvbearUuxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HN98rrSV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HN98rrSV"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso1621169a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778167986; x=1778772786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7nhUoAR6Jcd26gRFxFjvn522qchdq1VUddNVE/t1Uo=;
        b=HN98rrSVO3dpokO7ixPq8OaSHjK97LzfgMy2AqRT3hqt7qCp+P6T0y+5TbOTMfcufM
         ilTslzYbCi88d+3RXa1J0H7fDwQKbxPqiITfbXsc/0HJeBw7IvugqVsrj/06+xsHgDfW
         4Phh5xaQgO/nvwvh+tbDHmt1w0uled1pwIxuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167986; x=1778772786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7nhUoAR6Jcd26gRFxFjvn522qchdq1VUddNVE/t1Uo=;
        b=P6ZfjuQZruoK8lO7qImhkM+oTPEnqiOkXYDCqyVgbDZ6nB6ujJyFUYlU9ng6GkK2s8
         gi0vV/q9z99iUpydYWANyXXSCMbrb6S2ZNFRB9A9OumkWpqzpznhgaOzSZIylnaWwqmX
         rlRJ1F5DK/EACvQb4GS6t4HgKl+zGxAFh90GQERQE9214LUboScwM9UZfArXirM9lFtp
         sWH06Lfw0/7GnkHcsUPmQrkAeZGQ4UFQnPY3fQIr71mziin8r4TapmKC9rr73Xc7CxE1
         g2T+x3JwqvXv1QDU1VAOg5GvoM7TJygcJSobVINSkWAMI1WKU+nqQvUz+lJoud/pjtl/
         V5Lg==
X-Gm-Message-State: AOJu0Yz/YSgtAnmvmHaBswC2EEdhJP6Mz6hB3RwKcpJt3XlaUOJuDe+R
	P34Tzvga45jzl8Aofx3nn78bC8aipXQnehGFLe6zYFBYMBbsKehYx5dgnC08fUPIg1LfXBWTxg/
	wa/2h0kA=
X-Gm-Gg: AeBDies3SVNCdPPb4um+F5WWRZCe/eOMCdQFth39oRxgmo+aWfY3Fc1NVLgWxonar6C
	oZjtLTHU4/z9Z5FOgUBGz/Z72TxB9dJmz6NN21S53sHEdD26ZENU7F5QSJhL4KzufXFECVkDCx6
	qzFunrdTiD1t4+l/GAfiDkFZs0xBDowC1rJyPzARLLGq1jDUk/V00DIOt/BZsfm+UNBndoDMaO9
	AbbeTv4OY80Di+jxUr7uw3yS/8GlXZIvv7dcCm9Xf6y8XwTl+mUW47CDfz+weU9DxBMZTW5EZJv
	J6rykfXDjfQICbPk3dVrx9eUdEnEOIcc2mUl8PTRLrFJayyZNE28V7YrGH7CiZhBwDU3ZuZXl98
	KgW3Orb7f7U7TvB+tJHvBlJHqnlJMgRZ9uog+UHFOKYcqIoilDhS6qmm7AP9dQV/xr5r/e4ZmO1
	ILYJeKi9gXGJLdnGuyarfDX2xp4XRbOxBc+oeRGjL/LtsibvtWPt5WvXvqsPmIQbe8vaYUgAye0
	yneAlSxUyM=
X-Received: by 2002:a05:6402:1d4d:b0:678:9584:fb30 with SMTP id 4fb4d7f45d1cf-67d638a6f0dmr4347928a12.3.1778167985732;
        Thu, 07 May 2026 08:33:05 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90f072bsm2205678a12.12.2026.05.07.08.33.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:33:04 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so1352391a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 08:33:04 -0700 (PDT)
X-Received: by 2002:a05:6402:5407:b0:67d:2d17:da25 with SMTP id
 4fb4d7f45d1cf-67d642b04e8mr4096374a12.13.1778167983861; Thu, 07 May 2026
 08:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-13-viro@zeniv.linux.org.uk> <CAADWXX_dChuduyjE2=h4JsRkX1Tbjhgw47p0v9KOSbHkWCs7ng@mail.gmail.com>
 <20260505224256.GH3518998@ZenIV> <20260507073510.GL3518998@ZenIV>
In-Reply-To: <20260507073510.GL3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 May 2026 08:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ4G7hRDHdNGpdtyUONso-EZE84=TiuuQ-wFF6YWPF4w@mail.gmail.com>
X-Gm-Features: AVHnY4IUrlqRoKotIaa6QiFEOt21YTCyKCcA9BF3AHIpHarGtXtHYqATZG1QWdw
Message-ID: <CAHk-=wiZ4G7hRDHdNGpdtyUONso-EZE84=TiuuQ-wFF6YWPF4w@mail.gmail.com>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 00:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Does the following look sane to you?  That's pretty much #12--#15 combined,
> with hopefully saner commit message.

This looks fine to me. I htink some of the commit message might be
worth as actual comments in the code - like that rcu_read_lock() in
lock_for_kill().

Just a "we are dropping spinlock, take rcu lock to have unbroken rcu
read side protection"

Because that one is probably one of the subtler things in there now -
you pointed it out in the commit message, but for somebody just
reading the code...

            Linus
