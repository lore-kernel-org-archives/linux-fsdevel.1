Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933586;
	b=GJlGwbT3T+KObeypv7JxBEkkQY5SzGtnampOR8QFTQ/HYjbUKjjPuwCkv4FeWay9pyg4
	 XGXftwhc9yEp1K1D+z4QwiR78o7nESXhCDxvO6kQ4GU6W54aAgWro3rP4lh/RYyx+pbYP
	 PmZQ7FLShzH6a5rbwUYZ8x+tdFN+Niu08cKz6R/PzcK7iMUbc6mxE4G6Id4g8YsWH0Eug
	 0VSi6mhBVfj3BWUg6lybQYV2v1vaODYJZW1fWX/a0HoJRVNwS9CNtxLMb8H8qOwi8+MR6
	 V5Z8VTkL9MOewoUf0rWV+jwJScTRR11n8k8QVHCsCzpTYZCwMcyqw4hC5bPAWFYTmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/4F+/UcRHsLof3SKLCHcEO2D3rsOio5c6X0Z/n2CUGw=;
	b=Yvq+0gSxkMWkKAhq1MRFUYKagbqQLyA+fZSjVWyBmLW/eD5qnKb6CCQQv2RQ8XUmZFUM
	 Tzr6WZPD3QsYFOSa/tFfmQdFITVV8Yr8xeYC+ux512G7j34ZGI/lQwf5bsCbyswFVjowM
	 V4bdNz2Oz5f8GrMEpS/HR9QX8gqEF8H47XlFZVmPtSBsrNnEkwSpgYF4tcW6QLhYG55TB
	 xY71h2FmTjB8KGAMcpHmu6IGJnXa4ARbAyMvx/Xja7KrhUIrQ5KkfdsidEdhmy3Q/TJf7
	 XiVwk3eFj6L66tIkiISMdWIhMm9SCn3NLZtuB4JPKQ2goSK6MeCc887WzAzeCGZhGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="aesidvv/";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E789606A891
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E789606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aesidvv/
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b467581b98so982525e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794933584; x=1795538384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/4F+/UcRHsLof3SKLCHcEO2D3rsOio5c6X0Z/n2CUGw=;
        b=aesidvv/tWkl6ucd5vcg63Wz+nYZsmz2N4tlcBii1a0qmPtAjMp1D0BkM4s+kG+7vB
         J6noIj6TWK8JvWnlx5tONCVc5j3eP/3iK2OHAG5vof+0upQH042pml3mvWUEkiPxcfRP
         lO8mEe7+ckrl+Zrw5AdA2xWssqKCewrjvs7Ndvtc7ukDCecZNF5qbMtPXV89adzyCt9R
         YW+A58J7j0x1VKABDKxSt6F291Iqt8oIM/AD/88BR7vE/t4u6g6RttG9h62O2/mU4HGR
         tGUZ+G2WE0dPiIgu0v4WEB29+nU/VuGMlE/IKAdtuefyOFimXgW3oDkqALQe6SaZZrVV
         QbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933584; x=1795538384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4F+/UcRHsLof3SKLCHcEO2D3rsOio5c6X0Z/n2CUGw=;
        b=IPP4jJC/XJyxBeCMg5KLSvSZeIOgxQ1r2f3SdUbjemzta5IcmhCTJRejxD+tO+uXfo
         kKq6yppIDfJf+BScSH41i2fOnZMH6daM6WIWq3TPmdW8v+/9+23xTDxDT/Kg6GvtzbxM
         AGJbDC3S31ga7OU001EW5cDtWI5wvi/eAOio1u5iR7DJF47sP7LAkXz4KGbLrpPj0nFX
         XqhsZGZBzoOdS+0A5XkVML84W9iJbPdFBPiIgeTtHPgIENF9B0S68WQZCCE3tFFUZzgj
         KWrdysWtniZIwB7taIAu9begsA/Q/HPaBll7NnHqtyw302AxQKDLIQPW/tFqiI9ECo/l
         kljA==
X-Forwarded-Encrypted: i=1; AL+hErHN6aQSOoT2NclmSyRisQ7MAGeDNj8tfRfUGBu8MB7F6PGEPM2IFWMK0GgXJvenTpdoRZ/64efohx4RYVRF@vger.kernel.org
X-Gm-Message-State: APuU4Z8cG2hdbvJjG+qj0p7hxJ2OO3qQELMSpPUmt6jIgqOogflz0cwo
	fPyFEXaJM6KtWZx5ENsnstdmT8WsyEdCIK+7xM2OmXmMcPMmk2slupW9OYtxTyYq9cte
X-Gm-Gg: AYBFou3SL4uLl+pVmjI+h+EcN/OwUxJuWuZAMMB5nYfssjuX7RdmPJHgbSC6Gwgx15a
	Ro4y1lilg5mzskHZB5JEwoghPgV4SkG3b1Q2McDYqu230EnTF791iYViKyQYwdeHET8ZRWCGMdz
	Huzajk3DZ/m1nU9N6MzRF90JdXViTij7e2g4GjvQM56KsPG/wz5j/r94Ynlvr4+UDQHpfS2d/nd
	GUA5u4EE9XQB23HpFk57WWNs0kndHUqVstYAFT7jJedMxLaYYnYr2+5KmRi1IezCPH6OayyZrZx
	0vTjGBItgxcdHnKwn1ihQoVCEwL7J2FOEOXbdczHzRA0K6yxdv4CjYGSQ1H8ZoYuA6ij/9QW+T6
	muvVoJ/rNLe+7LLFJu3OnRemaGQs3em261WrBuHNDKb3n6BHov3MmmDP0FNAa58RIIC6XwEl/QI
	Jm6SAh9ug9mmhxmEcpXo+z1Ex88y4AYgoNZrixcFhJZ/Nmp9wW2F+fUNmtgFPm85XeIWXM4hb6B
	V2OB4dUJpLc4ImBYC5Xd80W8QW+p1sXCwQ4HKuXc7MJEWXuiSYlH23rnoa9R25Vz0qxOUWdwAhD
	/eIInwe/UFhofdNA+2Ot0vugX+9JsNzIZNTtJzJv8KktMa8xf87nG3H8Tk0cxlFyavZv1xgcGbh
	Z2A26SXkh3I2EVn0+Oc3T4HV7NxCQvE03mzrRTfpjPJKjgmt7yIDwHRa83cBsv8BWTfUwfXqfhR
	hKnw==
X-Received: by 2002:a05:600c:3551:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4bb55a99d21mr315125305e9.16.1794933584407;
        Tue, 17 Nov 2026 08:39:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b? (p200300cf572c2800dd2ac8cf5d96bf5b.dip0.t-ipconnect.de. [2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a38b9b986esm5481266f8f.59.2026.11.17.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:39:43 -0800 (PST)
Message-ID: <cf47c058f8944a427885e83214b8ad1c4268cbd8.camel@amutable.com>
Subject: Re: [PATCH net 2/2] selftests/net: check that a short SO_PEERPIDFD
 optlen fails
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Date: Tue, 17 Nov 2026 17:39:42 +0100
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-2-a93f56288501@kernel.org>
References: 
	<20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
	 <20261117-work-net-peerpidfd_short_optlen-v1-2-a93f56288501@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 16:25 +0100, Christian Brauner wrote:
> Cover SO_PEERPIDFD and SO_PEERPIDFD_THREAD with an optlen of 0 to 3:
>=20
> - getsockopt() fails with EINVAL
> - optlen and the buffer stay untouched
> - no pidfd is installed in the file descriptor table
>=20
> Check that a full-sized buffer still gets a pidfd.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0tools/testing/selftests/net/af_unix/scm_pidfd.c | 51
> +++++++++++++++++++++++++
> =C2=A01 file changed, 51 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> index cbe53fab44fc5..c26f055a19032 100644
> --- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> +++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> @@ -1155,4 +1155,55 @@ TEST(so_peerpidfd_thread)
> =C2=A0	close(server);
> =C2=A0}
> =C2=A0
> +/* The lowest free file descriptor, where the next pidfd would land.
> */
> +static int lowest_free_fd(int fd)
> +{
> +	int nfd;
> +
> +	nfd =3D dup(fd);
> +	if (nfd >=3D 0)
> +		close(nfd);
> +	return nfd;
> +}
> +
> +/* A short optlen must fail without installing a pidfd. */
> +TEST(so_peerpidfd_short_optlen)
> +{
> +	const int optnames[] =3D { SO_PEERPIDFD, SO_PEERPIDFD_THREAD
> };
> +	int sv[2], i, free_fd, pidfd;
> +	socklen_t len, optlen;
> +
> +	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, sv));
> +
> +	for (i =3D 0; i < ARRAY_SIZE(optnames); i++) {
> +		for (len =3D 0; len < sizeof(pidfd); len++) {
> +			free_fd =3D lowest_free_fd(sv[0]);
> +			ASSERT_LE(0, free_fd);
> +
> +			pidfd =3D -1;
> +			optlen =3D len;
> +			ASSERT_EQ(-1, getsockopt(sv[0], SOL_SOCKET,
> optnames[i],
> +						 &pidfd, &optlen));
> +			ASSERT_EQ(EINVAL, errno);
> +			EXPECT_EQ(len, optlen);
> +			EXPECT_EQ(-1, pidfd);
> +
> +			/* No pidfd was installed behind our back.
> */
> +			ASSERT_EQ(free_fd, lowest_free_fd(sv[0]));
> +		}
> +
> +		/* A full-sized buffer still gets the pidfd. */
> +		free_fd =3D lowest_free_fd(sv[0]);
> +		optlen =3D sizeof(pidfd);
> +		ASSERT_EQ(0, getsockopt(sv[0], SOL_SOCKET,
> optnames[i],
> +					&pidfd, &optlen));
> +		EXPECT_EQ(sizeof(pidfd), optlen);
> +		EXPECT_EQ(free_fd, pidfd);
> +		close(pidfd);
> +	}
> +
> +	close(sv[0]);
> +	close(sv[1]);
> +}
> +
> =C2=A0TEST_HARNESS_MAIN
