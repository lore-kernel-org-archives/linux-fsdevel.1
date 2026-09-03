Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36614AF9E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442162; cv=pass; b=PBf9pIG/sWZYMd6vb1ewvc/pqIYgzoueCDTETQLxUxfwEBzI9OLGfkBfBmpT7Ox5GRmzOiEfzIY40T2Np2h9sGhbw4khqfROecvUWCYpRjVwU5WnBWDyjmeInxdSPIeVxMaLE7PB2+BjjExYQHr5sJp3PRnwBm44Bg2Sln+R2RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442162; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJlABvM3ORtoBZL9FzG3nuvDwm6uN+xQX006jjGSJXQM+aX6mkzCtHUc1q7q5CtQwFb3jlFjiDcfF6W2wwiJPRz71ozr8G5f8ye8U/arIGTeswaYye0xzjYK2g1KU3DEnycBcbGfmSN244HuiYvy/0gC8hllVGeIYgaNc65gCUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d900ac39ffso2954945ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 06:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=LjwebkD3sIY1K7pUIsj+u0/WVoO//LEvGEJ2noeit3CGP0nNWHZ5tBDvJvqfsvDUlc
         IOWwKBS8UBNsl4GXg2JfnajwxFOmImICzGqH20U1Swe/SYwMB5ERUk/8M5UiO6M0AkYP
         4HnjdYUX5S4yiTclXH+0evrEl4XEJfYfoNLciXW19yQNB7vUZfCuocl5O7th/P4eUjch
         jxZ6ecrSD3VXeOMJdod49Ilm+x3+TY/4pIJXUDNeTQnqEuTfjcmW/BKISN94Pfdbhgn3
         LPa722EOXzpvXexWjVShrn60Bv/IkLqULgWZWRJQNMZ5r5nITnt7C/yXc5odLDHaYiRa
         9A2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=KMDGjgk8bYTFE5MXYNDxy3Rvwl6iPM+k7N9zwGFgEqE=;
        b=o6PW8aOGAYatvyB3KjbT+pMhEE8fSa7Z6jICUqUkZ1uHwKjoaK6XGp+mjtvImr5wSO
         ZM8BEeqa9iH0fVTVE34AgRXL3ctR0hBBzE5yGTRXd+9+Y8JxfO3OHO5qSFLMKv+ox2jP
         xOtxMDAxIQwiAFAnfMds74ZEBUsXTiH/bhL9hLXzL76wK3XBAmbRi9n+lHx2BkZPPK/u
         u9BSk+VysoejJCwWsY2IHTv+Dnrw3Y4xNgbUnFFRD6ce+dtA8wuKCdIKVabJ47wAAQmP
         Eg3r73EoFIsLdxZsJm80jenHVTlAJedgv4+agNa8lZMDIAjsRR3pHTfCoBxyeyUBLNkk
         4csg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=UBbh7XwVSzjLRkcQLEF+kv6v4qKwk8a6bpgKW0NH0V860mAczWGEQ3ZL7PpUIKrM41
         Fmx5AWmHodGGtmiXXC+XrFKDN6OXF2D3HwPiCy6th4u2t9GUbBC/RrSm2VMv0kNIvuws
         W8CNdaHLZVLqMDgXincKkS99oVwID2JDL1BOF3FJ58uI5hI9l0VLlHgOuXIOqKibC6nX
         jWHd5nDc1ZROAg9T9ZkRTcjYSLjATXYEAzQQgVu88OLKGOGX4YpEjbWA83agHxgAb3GW
         AJ3q8G3Y/F2NlI8TgiAXh6R8YIFbLhDT3PlZTeYDkVLERRtu9mCD/dvHVYyQbpAC6+Pm
         N/Ag==
X-Forwarded-Encrypted: i=1; AKwUvByjJSNfSKrQ5xb0qRDDk8I8p8Axy1bfjjTUp0pJyg2OvCESm7qJ+/E7rDmlaAzfje+uBFCQr7OVowu5dAuK@vger.kernel.org
X-Gm-Message-State: AFuF++kfPIQQAk9ZikIV+RVVdFZOWEr46Rv6Brb3Dq9AC6v4YFA5rRmN
	YJgWx6s+HpEuVrfrGTWCk3N3XRev4gD/GgW+C7gH2R2lParSdIpM/biFFAXHXWFwhUHhrVH1d7K
	qHusEep3xiW0Vf/hRV2r5MEuwEu390+M=
X-Gm-Gg: AYBFou2lV66hvMgFGlL3Vay27cdbXIvjJjgGha8bSN6uuPuTHsn52Zi9Qdz1Icni3GH
	A3zw3HshsHf0PeKq2CoO+QihHsJNQRxZAcnE1TAzaeucXps6JZ13OmW7yckvBt97TAzI/qMcDqK
	YN+YK1BJ04bhH1vmRkd56PRrudGm6Ch/7jLXnId440iO9l417qs33NZv5UPwHOihXT947QNA9dH
	Zlv2bySx3xBwwRbGxmdJ53CTko9XQkuoPxG1WAxZm6ziee9GQdE9pj5faIltswx7Kleu69w83Ko
	QehxAYHJ9c0Yg4a9VXKfYZED4V+yYasUDs8zy7WrWx2FJMywe6Q/eB4oeMNkWhoC8xUiWQ7EP/R
	+5qqwIZx9Yo080y4UvqDcZSIbSLy7lh/g7NRVedO769FfJKcNxUzH/t78W5zP
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
