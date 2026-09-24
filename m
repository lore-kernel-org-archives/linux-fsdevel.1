Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758E48CD7A;
	Thu, 24 Sep 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256605; cv=none; b=dmbBa86dBsPWOQu4VARDHfzezdLIPaHyoDcDAYsJCJuBxD419+raefv5gSFJeWH5OB/JbclZuxFUUQiWoKO5ECrp0xlPqaZbMInRTrKIJ/K02hYv47WmFKJA4yEBg2CR8SaJTQDNmr7Fpp3rm36tURzb6Xda4Wix8kkC/e0gQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256605; c=relaxed/simple;
	bh=Vo8Et3udG88p7Xx21mxXL1jRfA5GsE1nmLm7y/yyOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e03YUcES6tAWxLC5TRsGdOohHEmbAA5/Mgsi3ojZa93nG31Brt2XG9dCpq1Armua2cVuwBRVmKUg5TMzew1LQ1NQ6RakYNcn4zdyLERgNqsclf92h/OcL73ntyudqBVh+v2EUuWcqClmBSzK3lyfEJyUYad52MzDTK0kgXVADeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb5Pj3PJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb5Pj3PJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAD71F000FF;
	Thu, 24 Sep 2026 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256595;
	bh=BS3ZGYqgi8oWou6uxnqnX+lZzdn4N+yDj+sEZP5b2Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pb5Pj3PJfrytk7DtvSenvpKqUzw0bw6yB40POGqjhoY3fy2evj4RrWx6cCFwykqjG
	 BV8YOSwYR2H6w4w1eMcWM8Lvmo6ccviQJaHU5wOnPqdjoEUI9bkY4XaN4WcfxKDOi1
	 omNO/oG3/Ks2O3P4RiBQ/1dCKCpulL6dyA73EvRQ6Cb9JQprfuQN3yg7jFxuigTZh+
	 +mEMOAklnJ9Ube7zJtzkIXkYgvD09Ol1xwYWqFTPIol8mfAMTS6GRTRV7/M0rQicM6
	 Q+iPTxMya49Bi8eR1jbFuBoBn9P7A+zgB4keLpk+b8nRPibSqrAjx5HF4HX/7b2lY4
	 a4TtZTjU83tug==
Date: Thu, 24 Sep 2026 15:29:49 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] sysctl: add typed field descriptors
Message-ID: <gho2r73sgnidz4yehymicxx2w5lwfpe65wcawlsr4ph7pkebpq@ppavdifvskcz>
References: <cover.1789987960.git.legion@kernel.org>
 <d95ae93f371d170de2899f6ce5aab183a2f9888c.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ul3wunote6v2asse"
Content-Disposition: inline
In-Reply-To: <d95ae93f371d170de2899f6ce5aab183a2f9888c.1789987960.git.legion@kernel.org>


--ul3wunote6v2asse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:54:50PM +0200, Alexey Gladkov wrote:
> Several sysctl users duplicate ctl_table arrays at registration time so
> data and limit pointers can be redirected to namespace or device state.
> The copies consume memory for every instance and their index-based
> fixups silently depend on the source table order.
>=20
> Add sysctl_field as an alternative static descriptor. A field records
> the value kind and a checked offset into an object selected by a
> registration context. Type-specific offset helpers verify the backing
> member type at build time, while the core derives the legacy proc
> handler, size and limit pointers from the field kind.
>=20
> Keep ctl_table as the interface used by proc handlers, permissions and
> BPF by materializing one entry on the stack when those paths need it.
> Existing ctl_table registrations are unchanged, and converted users can
> share one read-only descriptor array without allocating a table copy.
>=20
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/proc/proc_sysctl.c  | 289 +++++++++++++++++++++++++++++++++++++----
>  include/linux/sysctl.h | 143 +++++++++++++++++++-
>  2 files changed, 400 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b5cb219bcdbc..73f3408b2043 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -18,6 +18,7 @@
>  #include <linux/mount.h>
>  #include <linux/kmemleak.h>
>  #include <linux/lockdep.h>
> +#include <linux/overflow.h>
>  #include "internal.h"
> =20
>  #define list_for_each_table_entry(index, header)			\
> @@ -91,28 +92,178 @@ static int sysctl_follow_link(struct ctl_table_heade=
r **phead, size_t *pindex);
>  static int insert_links(struct ctl_table_header *head);
>  static void put_links(struct ctl_table_header *header);
> =20
> +static inline bool is_field_table(const struct ctl_table_header *head)
> +{
> +	return head->table_kind =3D=3D SYSCTL_TABLE_KIND_FIELD;
> +}
> +
>  static const char *sysctl_entry_procname(struct ctl_table_header *head,
>  					 size_t index)
>  {
> +	if (is_field_table(head))
> +		return head->ctl_fields[index].procname;
> +
>  	return head->ctl_table[index].procname;
>  }
> =20
>  static umode_t sysctl_entry_mode(struct ctl_table_header *head, size_t i=
ndex)
>  {
> -	return head->ctl_table[index].mode;
> +	const struct sysctl_field *field;
> +
> +	if (!is_field_table(head))
> +		return head->ctl_table[index].mode;
> +
> +	field =3D &head->ctl_fields[index];
> +
> +	if (field->mode_fn) {
> +		lockdep_assert_not_held(&sysctl_lock);
> +		return field->mode_fn(head->ctx);
> +	}
> +
> +	return field->mode;
> +}
> +
> +static bool sysctl_entry_is_dir(const struct ctl_table_header *head,
> +				size_t index)
> +{
> +	/* Do not call field mode_fn callback while holding sysctl_lock. */
> +	if (is_field_table(head))
> +		return false;
> +
> +	return S_ISDIR(head->ctl_table[index].mode);
> +}
> +
> +static bool sysctl_entry_is_link(const struct ctl_table_header *head,
> +				 size_t index)
> +{
> +	if (is_field_table(head))
> +		return false;
> +
> +	return S_ISLNK(head->ctl_table[index].mode);
>  }
> =20
>  static struct ctl_table_poll *sysctl_entry_poll(struct ctl_table_header =
*head,
>  						size_t index)
>  {
> +	if (is_field_table(head))
> +		return NULL;
> +
>  	return head->ctl_table[index].poll;
>  }
> =20
> +static void *sysctl_context_object(const struct sysctl_context *ctx)
> +{
> +	if (!ctx)
> +		return NULL;
> +	if (ctx->object)
> +		return ctx->object(ctx);
> +
> +	switch (ctx->type) {
> +	case SYSCTL_CONTEXT_USER_NS:
> +		return ctx->ns.user_ns;
> +	case SYSCTL_CONTEXT_IPC_NS:
> +		return ctx->ns.ipc_ns;
> +	case SYSCTL_CONTEXT_PID_NS:
> +		return ctx->ns.pid_ns;
> +	case SYSCTL_CONTEXT_NET_NS:
> +		return ctx->ns.net_ns;
> +	}

Does this mean that for every case where sysctl needs a context, you
need a context type? Could you gather some of them together?

> +
> +	return NULL;
> +}
> +
> +static void *sysctl_context_data(const struct sysctl_context *ctx,
> +				 size_t offset, size_t size)
> +{
> +	void *object =3D sysctl_context_object(ctx);
> +
> +	if (!object || offset > ctx->object_size ||
> +	    size > ctx->object_size - offset)
> +		return NULL;
> +
> +	return (char *)object + offset;
> +}
> +
>  static const struct ctl_table *
>  sysctl_entry_table(struct ctl_table_header *head, size_t index,
>  		   struct ctl_table *table)
>  {
> -	return &head->ctl_table[index];
> +	const struct sysctl_field *field;
> +
> +	if (!is_field_table(head))
> +		return &head->ctl_table[index];
> +
> +	field =3D &head->ctl_fields[index];
> +
> +	memset(table, 0, sizeof(*table));
> +	table->procname =3D field->procname;
> +	table->mode =3D field->mode;
> +
> +	if (field->mode_fn)
> +		table->mode =3D field->mode_fn(head->ctx);
> +
> +	switch (field->type) {
> +	case SYSCTL_FIELD_NO_DATA:
> +		break;
> +	case SYSCTL_FIELD_STRING:
> +		table->proc_handler =3D proc_dostring;
> +		table->maxlen =3D field->maxlen;
> +		break;
> +	case SYSCTL_FIELD_BOOL:
> +		table->proc_handler =3D proc_dobool;
> +		table->maxlen =3D sizeof(bool);
> +		break;
> +	case SYSCTL_FIELD_U8:
> +	case SYSCTL_FIELD_U8_MINMAX:
> +		table->proc_handler =3D proc_dou8vec_minmax;
> +		table->maxlen =3D sizeof(u8);
> +		table->extra1 =3D field->u8_limits.min;
> +		table->extra2 =3D field->u8_limits.max;
> +		break;
> +	case SYSCTL_FIELD_INT:
> +	case SYSCTL_FIELD_INT_MINMAX:
> +		table->proc_handler =3D field->type =3D=3D SYSCTL_FIELD_INT ?
> +				      proc_dointvec : proc_dointvec_minmax;
> +		table->maxlen =3D sizeof(int);
> +		table->extra1 =3D field->int_limits.min;
> +		table->extra2 =3D field->int_limits.max;
> +		break;
> +	case SYSCTL_FIELD_UINT:
> +	case SYSCTL_FIELD_UINT_MINMAX:
> +		table->proc_handler =3D field->type =3D=3D SYSCTL_FIELD_UINT ?
> +				      proc_douintvec : proc_douintvec_minmax;
> +		table->maxlen =3D sizeof(unsigned int);
> +		table->extra1 =3D field->uint_limits.min;
> +		table->extra2 =3D field->uint_limits.max;
> +		break;
> +	case SYSCTL_FIELD_LONG:
> +	case SYSCTL_FIELD_LONG_MINMAX:
> +		table->proc_handler =3D proc_doulongvec_minmax;
> +		table->maxlen =3D sizeof(long);
> +		table->extra1 =3D field->long_limits.min;
> +		table->extra2 =3D field->long_limits.max;
> +		break;
> +	case SYSCTL_FIELD_ULONG:
> +	case SYSCTL_FIELD_ULONG_MINMAX:
> +		table->proc_handler =3D proc_doulongvec_minmax;
> +		table->maxlen =3D sizeof(unsigned long);
> +		table->extra1 =3D field->ulong_limits.min;
> +		table->extra2 =3D field->ulong_limits.max;
> +		break;
> +	case SYSCTL_FIELD_SIZE_T:
> +		table->proc_handler =3D proc_doulongvec_minmax;
> +		table->maxlen =3D sizeof(size_t);
> +		break;
> +	}

Several things:
1. YOu replace all ctl_table members. What about the cases where you
   just need to replace one member because the others are the same for
   all the namespaces?

2. So if ctl_table grows another member, this function needs to be
   updated. right?

3. I get that the SYSCTL_FIELD_ULONG is a type. But the
   SYSCTL_FIELD_ULONG_MINMAX is not a type. "minmax" in sysctl usually
   means that we do a range check. Why is it treated like a type here?

> +
> +	if (field->type !=3D SYSCTL_FIELD_NO_DATA)
> +		table->data =3D sysctl_context_data(head->ctx, field->data_offset, tab=
le->maxlen);
> +	if (field->proc_handler)
> +		table->proc_handler =3D field->proc_handler;
> +	if (field->maxlen)
> +		table->maxlen =3D field->maxlen;
> +
> +	return table;
>  }
> =20
>  static void sysctl_print_dir(struct ctl_dir *dir)
> @@ -212,9 +363,17 @@ static void erase_entry(struct ctl_table_header *hea=
d, size_t index)
> =20
>  static void init_header(struct ctl_table_header *head,
>  	struct ctl_table_root *root, struct ctl_table_set *set,
> -	struct ctl_node *node, const struct ctl_table *table, size_t table_size)
> +	struct ctl_node *node, const struct ctl_table *table,
> +	const struct sysctl_field *fields, size_t table_size,
> +	const struct sysctl_context *ctx)
>  {
> -	head->ctl_table =3D table;
> +	if (fields) {
> +		head->ctl_fields =3D fields;
> +		head->table_kind =3D SYSCTL_TABLE_KIND_FIELD;
> +	} else {
> +		head->ctl_table =3D table;
> +		head->table_kind =3D SYSCTL_TABLE_KIND_TABLE;
> +	}
>  	head->ctl_table_size =3D table_size;
>  	head->ctl_table_arg =3D table;
>  	head->used =3D 0;
> @@ -223,6 +382,7 @@ static void init_header(struct ctl_table_header *head,
>  	head->unregistering =3D NULL;
>  	head->root =3D root;
>  	head->set =3D set;
> +	head->ctx =3D ctx;
>  	head->parent =3D NULL;
>  	head->node =3D node;
>  	INIT_HLIST_HEAD(&head->inodes);
> @@ -981,7 +1141,7 @@ static struct ctl_dir *find_subdir(struct ctl_dir *d=
ir,
> =20
>  	if (!find_entry(&head, &index, dir, name, namelen))
>  		return ERR_PTR(-ENOENT);
> -	if (!S_ISDIR(sysctl_entry_mode(head, index)))
> +	if (!sysctl_entry_is_dir(head, index))
>  		return ERR_PTR(-ENOTDIR);
>  	return container_of(head, struct ctl_dir, header);
>  }
> @@ -1006,7 +1166,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set=
 *set,
>  	memcpy(new_name, name, namelen);
>  	table[0].procname =3D new_name;
>  	table[0].mode =3D S_IFDIR|S_IRUGO|S_IXUGO;
> -	init_header(&new->header, set->dir.header.root, set, node, table, 1);
> +	init_header(&new->header, set->dir.header.root, set, node, table, NULL,
> +		    1, NULL);
> =20
>  	return new;
>  }
> @@ -1187,6 +1348,10 @@ static int sysctl_check_table(const char *path, st=
ruct ctl_table_header *header)
>  		entry =3D sysctl_entry_table(header, index, &table);
>  		if (!entry->procname)
>  			err |=3D sysctl_err(path, entry, "procname is null");
> +		if (is_field_table(header) &&
> +		    header->ctl_fields[index].type !=3D SYSCTL_FIELD_NO_DATA &&
> +		    !entry->data)
> +			err |=3D sysctl_err(path, entry, "No data");
>  		if ((entry->proc_handler =3D=3D proc_dostring) ||
>  		    (entry->proc_handler =3D=3D proc_dobool) ||
>  		    (entry->proc_handler =3D=3D proc_dointvec) ||
> @@ -1199,7 +1364,7 @@ static int sysctl_check_table(const char *path, str=
uct ctl_table_header *header)
>  		    (entry->proc_handler =3D=3D proc_dointvec_ms_jiffies) ||
>  		    (entry->proc_handler =3D=3D proc_doulongvec_minmax) ||
>  		    (entry->proc_handler =3D=3D proc_doulongvec_ms_jiffies_minmax)) {
> -			if (!entry->data)
> +			if (!is_field_table(header) && !entry->data)
>  				err |=3D sysctl_err(path, entry, "No data");
>  			if (!entry->maxlen)
>  				err |=3D sysctl_err(path, entry, "No maxlen");
> @@ -1255,7 +1420,7 @@ static struct ctl_table_header *new_links(struct ct=
l_dir *dir, struct ctl_table_
>  		link++;
>  	}
>  	init_header(links, dir->header.root, dir->header.set, node, link_table,
> -		    head->ctl_table_size);
> +		    NULL, head->ctl_table_size, NULL);
>  	links->nreg =3D head->ctl_table_size;
> =20
>  	return links;
> @@ -1279,10 +1444,10 @@ static bool get_links(struct ctl_dir *dir,
>  		if (!find_entry(&tmp_head, &link_index, dir, procname,
>  				strlen(procname)))
>  			return false;
> -		if (S_ISDIR(sysctl_entry_mode(tmp_head, link_index)) &&
> -		    S_ISDIR(sysctl_entry_mode(header, index)))
> +		if (sysctl_entry_is_dir(tmp_head, link_index) &&
> +		    sysctl_entry_is_dir(header, index))
>  			continue;
> -		if (S_ISLNK(sysctl_entry_mode(tmp_head, link_index)) &&
> +		if (sysctl_entry_is_link(tmp_head, link_index) &&
>  		    tmp_head->ctl_table[link_index].data =3D=3D link_root)
>  			continue;
>  		return false;
> @@ -1369,18 +1534,25 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_=
dir *dir, const char *path)
>  }
> =20
>  /**
> - * __register_sysctl_table - register a leaf sysctl table
> + * __register_sysctl_table_internal - register a leaf sysctl table
>   * @set: Sysctl tree to register on
>   * @path: The path to the directory the sysctl table is in.
> + * @table: The top-level ctl_table array, or %NULL when registering @fie=
lds.
> + * @fields: The top-level ctl_field array, or %NULL when registering @ta=
ble.
> + * @table_size: The number of elements in @table or @fields.
> + * @ctx: Optional context used to resolve @fields entries.
> + * @ctx_size: Size of @ctx, including any wrapper object that embeds it.
>   *
> - * @table: the top-level table structure. This table should not be free'd
> - *         after registration. So it should not be used on stack. It can=
 either
> - *         be a global or dynamically allocated by the caller and free'd=
 later
> - *         after sysctl unregistration.
> - * @table_size : The number of elements in table
> + * Register a sysctl table hierarchy. One of @table or @fields must be
> + * provided. The descriptor array should not be freed after registration=
, so it
> + * should not be used on stack. It can either be global or dynamically
> + * allocated by the caller and freed later after sysctl unregistration.
>   *
> - * Register a sysctl table hierarchy. @table should be a filled in ctl_t=
able
> - * array.
> + * If @ctx points to a wrapper object, &struct sysctl_context must be th=
e first
> + * member so @ctx can be copied together with the rest of that object.
> + * Data offsets stored in @fields are checked against @ctx->object_size =
and
> + * applied to the namespace selected by @ctx->ns. A context wrapper may =
provide
> + * @ctx->object for tables whose data belongs to another object.
>   *
>   * The members of the &struct ctl_table structure are used as follows:
>   * procname - the name of the sysctl file under /proc/sys. Set to %NULL =
to not
> @@ -1411,25 +1583,69 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_=
dir *dir, const char *path)
>   * This routine returns %NULL on a failure to register, and a pointer
>   * to the table header on success.
>   */
> -struct ctl_table_header *__register_sysctl_table(
> -	struct ctl_table_set *set,
> -	const char *path, const struct ctl_table *table, size_t table_size)
> +static struct ctl_table_header *
> +__register_sysctl_table_internal(struct ctl_table_set *set, const char *=
path,
> +				 const struct ctl_table *table,
> +				 const struct sysctl_field *fields,

It seems strange that these two args are getting passed to the
same function, but cannot coexist. It is also strange that they hold
very similar data.

It also makes me feel uneasy as we will have to think about two paths in
the same function.

> +				 size_t table_size,
> +				 const struct sysctl_context *ctx, size_t ctx_size)
>  {
>  	struct ctl_table_root *root =3D set->dir.header.root;
>  	struct ctl_table_header *header;
>  	struct ctl_dir *dir;
>  	struct ctl_node *node;
> +	const struct sysctl_context *header_ctx =3D NULL;
> +	size_t nodes_size;
>  	size_t alloc_size;
> +	size_t context_offset;
> +
> +	if (!!table =3D=3D !!fields)
> +		return NULL;
> +
> +	if (ctx && ctx_size < sizeof(*ctx))
> +		return NULL;
> +
> +	if (!ctx && ctx_size)
> +		return NULL;
> +
> +	if (fields && (!ctx || !ctx->object_size ||
> +		       !sysctl_context_object(ctx)))
> +		return NULL;
> +
> +	if (check_mul_overflow(sizeof(struct ctl_node), table_size, &nodes_size=
))
> +		return NULL;
> +
> +	if (check_add_overflow(sizeof(*header), nodes_size, &context_offset))
> +		return NULL;
> +
> +	/*
> +	 * Store the copied context after the ctl_node array. struct sysctl_con=
text
> +	 * is the first member of any caller-defined wrapper, whose alignment
> +	 * must not exceed that of struct sysctl_context.
> +	 */
> +	if (ctx) {
> +		if (check_add_overflow(context_offset,
> +				       __alignof__(*ctx) - 1, &context_offset))
> +			return NULL;
> +		context_offset =3D ALIGN_DOWN(context_offset, __alignof__(*ctx));
> +	}
> =20
> -	alloc_size =3D sizeof(struct ctl_table_header) +
> -		     sizeof(struct ctl_node) * table_size;
> +	if (check_add_overflow(context_offset, ctx_size, &alloc_size))
> +		return NULL;
> =20
>  	header =3D kzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
>  	if (!header)
>  		return NULL;
> =20
>  	node =3D (struct ctl_node *)(header + 1);
> -	init_header(header, root, set, node, table, table_size);
> +	if (ctx) {
> +		header_ctx =3D (const struct sysctl_context *)((void *)header +
> +							   context_offset);
> +		memcpy((void *)header_ctx, ctx, ctx_size);
> +	}
> +
> +	init_header(header, root, set, node, table, fields, table_size,
> +		    header_ctx);
>  	if (sysctl_check_table(path, header))
>  		goto fail;
> =20
> @@ -1459,6 +1675,25 @@ struct ctl_table_header *__register_sysctl_table(
>  	return NULL;
>  }
> =20
> +struct ctl_table_header *
> +__register_sysctl_fields(struct ctl_table_set *set, const char *path,
> +			 const struct sysctl_field *fields, size_t field_count,
> +			 const struct sysctl_context *ctx, size_t ctx_size)
> +{
> +	return __register_sysctl_table_internal(set, path, NULL, fields,
> +						field_count, ctx, ctx_size);
> +}
> +EXPORT_SYMBOL(__register_sysctl_fields);
> +
> +struct ctl_table_header *
> +__register_sysctl_table(struct ctl_table_set *set, const char *path,
> +			const struct ctl_table *table, size_t table_size)
> +{
> +	return __register_sysctl_table_internal(set, path, table, NULL,
> +						table_size, NULL, 0);
> +}
> +EXPORT_SYMBOL(__register_sysctl_table);
> +
>  /**
>   * register_sysctl_sz - register a sysctl table
>   * @path: The path to the directory the sysctl table is in. If the path
> @@ -1547,7 +1782,7 @@ static void put_links(struct ctl_table_header *head=
er)
> =20
>  		if (link &&
>  		    ((S_ISDIR(link->mode) &&
> -		      S_ISDIR(sysctl_entry_mode(header, index))) ||
> +		      sysctl_entry_is_dir(header, index)) ||
>  		     (S_ISLNK(link->mode) && (link->data =3D=3D root)))) {
>  			drop_sysctl_table(link_head);
>  		} else {
> @@ -1603,7 +1838,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
>  {
>  	memset(set, 0, sizeof(*set));
>  	set->is_seen =3D is_seen;
> -	init_header(&set->dir.header, root, set, NULL, root_table, 1);
> +	init_header(&set->dir.header, root, set, NULL, root_table, NULL, 1, NUL=
L);
>  }
> =20
>  void retire_sysctl_set(struct ctl_table_set *set)
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 7139a4c72736..de59fcd139cd 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -22,20 +22,27 @@
>  #ifndef _LINUX_SYSCTL_H
>  #define _LINUX_SYSCTL_H
> =20
> +#include <linux/build_bug.h>
>  #include <linux/list.h>
>  #include <linux/rcupdate.h>
>  #include <linux/wait.h>
>  #include <linux/rbtree.h>
> +#include <linux/stddef.h>
>  #include <linux/uidgid.h>
>  #include <uapi/linux/sysctl.h>
> =20
>  /* For the /proc/sys support */
>  struct completion;
>  struct ctl_table;
> +struct sysctl_field;
>  struct nsproxy;
>  struct ctl_table_root;
>  struct ctl_table_header;
>  struct ctl_dir;
> +struct ipc_namespace;
> +struct net;
> +struct pid_namespace;
> +struct user_namespace;
> =20
>  /* Keep the same order as in fs/proc/proc_sysctl.c */
>  #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
> @@ -81,6 +88,27 @@ extern const int sysctl_vals[];
>  extern const unsigned long sysctl_long_vals[];
>  extern const unsigned int sysctl_uint_vals[];
> =20
> +enum sysctl_context_type {
> +	SYSCTL_CONTEXT_USER_NS,
> +	SYSCTL_CONTEXT_IPC_NS,
> +	SYSCTL_CONTEXT_PID_NS,
> +	SYSCTL_CONTEXT_NET_NS,
> +};
> +
> +union sysctl_namespace {
> +	struct user_namespace *user_ns;
> +	struct ipc_namespace *ipc_ns;
> +	struct pid_namespace *pid_ns;
> +	struct net *net_ns;
> +};
> +
> +struct sysctl_context {
> +	enum sysctl_context_type type;
> +	size_t object_size;
> +	union sysctl_namespace ns;
> +	void *(*object)(const struct sysctl_context *ctx);
> +};
> +
>  typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
>  			 size_t *lenp, loff_t *ppos);
> =20
> @@ -237,30 +265,114 @@ struct ctl_table {
>  	void *extra2;
>  } __randomize_layout;
> =20
> +enum sysctl_field_type {
> +	SYSCTL_FIELD_NO_DATA,
> +	SYSCTL_FIELD_STRING,
> +	SYSCTL_FIELD_BOOL,
> +	SYSCTL_FIELD_U8,
> +	SYSCTL_FIELD_U8_MINMAX,
> +	SYSCTL_FIELD_INT,
> +	SYSCTL_FIELD_INT_MINMAX,
> +	SYSCTL_FIELD_UINT,
> +	SYSCTL_FIELD_UINT_MINMAX,
> +	SYSCTL_FIELD_LONG,
> +	SYSCTL_FIELD_LONG_MINMAX,
> +	SYSCTL_FIELD_ULONG,
> +	SYSCTL_FIELD_ULONG_MINMAX,
> +	SYSCTL_FIELD_SIZE_T,
> +};
> +
> +#define __SYSCTL_FIELD_OFFSET(_struct, _field, _type)				\
> +	(offsetof(_struct, _field) +						\
> +	 BUILD_BUG_ON_ZERO(!__same_type(((_struct *)0)->_field, *(_type *)0)))
> +
> +#define SYSCTL_FIELD_INT_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_=
struct, _field, int)
> +#define SYSCTL_FIELD_UINT_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(=
_struct, _field, unsigned int)
> +#define SYSCTL_FIELD_LONG_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(=
_struct, _field, long)
> +#define SYSCTL_FIELD_ULONG_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET=
(_struct, _field, unsigned long)
> +#define SYSCTL_FIELD_SIZE_T_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSE=
T(_struct, _field, size_t)
> +
> +struct sysctl_field_u8_limits {
> +	unsigned int *min;
> +	unsigned int *max;
> +};
> +
> +struct sysctl_field_int_limits {
> +	int *min;
> +	int *max;
> +};
> +
> +struct sysctl_field_uint_limits {
> +	unsigned int *min;
> +	unsigned int *max;
> +};
> +
> +struct sysctl_field_long_limits {
> +	long *min;
> +	long *max;
> +};
> +
> +struct sysctl_field_ulong_limits {
> +	unsigned long *min;
> +	unsigned long *max;
> +};

These min,max values have been an ongoing issue. Here we just propagate
them further.

> +
> +struct sysctl_field {
> +	const char *procname;
> +	umode_t mode;
> +	enum sysctl_field_type type;
> +	umode_t (*mode_fn)(const struct sysctl_context *ctx);
> +	proc_handler *proc_handler;
> +	int maxlen;
> +	size_t data_offset;
> +	union {
> +		struct sysctl_field_u8_limits		u8_limits;
> +		struct sysctl_field_int_limits		int_limits;
> +		struct sysctl_field_uint_limits		uint_limits;
> +		struct sysctl_field_long_limits		long_limits;
> +		struct sysctl_field_ulong_limits	ulong_limits;
> +	};
> +} __randomize_layout;
> +
>  struct ctl_node {
>  	struct rb_node node;
>  	struct ctl_table_header *header;
>  };
> =20
>  /**
> - * struct ctl_table_header - maintains dynamic lists of struct ctl_table=
 trees
> - * @ctl_table: pointer to the first element in ctl_table array
> - * @ctl_table_size: number of elements pointed by @ctl_table
> + * struct ctl_table_header - maintains dynamic lists of sysctl descripto=
r trees
> + * @ctl_table: pointer to the first element in a legacy ctl_table array
> + * @ctl_fields: pointer to the first element in a ctl_field array
> + * @ctl_table_size: number of elements pointed to by @ctl_table or @ctl_=
fields
>   * @used: The entry will never be touched when equal to 0.
>   * @count: Upped every time something is added to @inodes and downed eve=
ry time
>   *         something is removed from inodes
>   * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
> - * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_s=
ysctl ->d_compare()"
> + * @rcu: delays freeing the header until after an RCU grace period
> + * @unregistering: completion used while unregistering the header
> + * @ctl_table_arg: original legacy ctl_table passed at registration, or =
NULL
> + * @ctx: copied registration context used to resolve ctl_field entries
> + * @root: sysctl tree containing this header
> + * @set: sysctl set containing this header
> + * @parent: parent directory of this header
> + * @node: array of nodes corresponding to the descriptor entries
> + * @inodes: inodes currently referring to this header
>   *
>   * @type: Enumeration to differentiate between ctl target types:
>   * type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerat=
ions
>   * type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently em=
pty dir
>   *                                            target to serve as a mount=
 point
> + * @table_kind: descriptor format stored in this header
> + * @table_kind.SYSCTL_TABLE_KIND_TABLE: legacy ctl_table descriptors
> + * @table_kind.SYSCTL_TABLE_KIND_FIELD: typed ctl_field descriptors
>   */
>  struct ctl_table_header {
>  	union {
>  		struct {
> -			const struct ctl_table *ctl_table;
> +			union {
> +				const struct ctl_table *ctl_table;
> +				const struct sysctl_field *ctl_fields;
> +			};
>  			int ctl_table_size;
>  			int used;
>  			int count;
> @@ -275,10 +387,15 @@ struct ctl_table_header {
>  	struct ctl_dir *parent;
>  	struct ctl_node *node;
>  	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
> +	const struct sysctl_context *ctx;
>  	enum {
>  		SYSCTL_TABLE_TYPE_DEFAULT,
>  		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
>  	} type;
> +	enum {
> +		SYSCTL_TABLE_KIND_TABLE,
> +		SYSCTL_TABLE_KIND_FIELD,
> +	} table_kind;
>  };
> =20
>  struct ctl_dir {
> @@ -303,6 +420,10 @@ struct ctl_table_root {
>  #define register_sysctl(path, table)	\
>  	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> =20
> +#define register_sysctl_fields(set, path, fields, ctx)			\
> +	__register_sysctl_fields(set, path, fields, ARRAY_SIZE(fields),	\
> +				 (ctx), sizeof(*(ctx)))
> +
>  #ifdef CONFIG_SYSCTL
> =20
>  void proc_sys_poll_notify(struct ctl_table_poll *poll);
> @@ -315,6 +436,10 @@ extern void retire_sysctl_set(struct ctl_table_set *=
set);
>  struct ctl_table_header *__register_sysctl_table(
>  	struct ctl_table_set *set,
>  	const char *path, const struct ctl_table *table, size_t table_size);
> +struct ctl_table_header *
> +__register_sysctl_fields(struct ctl_table_set *set, const char *path,
> +			 const struct sysctl_field *fields, size_t field_count,
> +			 const struct sysctl_context *ctx, size_t ctx_size);
>  struct ctl_table_header *register_sysctl_sz(const char *path, const stru=
ct ctl_table *table,
>  					    size_t table_size);
>  void unregister_sysctl_table(struct ctl_table_header * table);
> @@ -350,6 +475,14 @@ static inline struct ctl_table_header *register_sysc=
tl_sz(const char *path,
>  	return NULL;
>  }
> =20
> +static inline struct ctl_table_header *
> +__register_sysctl_fields(struct ctl_table_set *set, const char *path,
> +			 const struct sysctl_field *fields, size_t field_count,
> +			 const struct sysctl_context *ctx, size_t ctx_size)
> +{
> +	return NULL;
> +}
> +
>  static inline void unregister_sysctl_table(struct ctl_table_header * tab=
le)
>  {
>  }
> --=20
> 2.55.0
>=20

--ul3wunote6v2asse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq1Jc0ACgkQupfNUreW
QU/g1Av/ZDRYANCtiVZv2Dgp6n2c4DraoifVcimDrnqzmTJyV8PMNsnsyM3nHTVR
BHHPlv8NGOC6JMWGQKRqrPM+6vCbOPOSkrJl5BrK0ZH7/vSnXqmX2xE/nPy5Vy6N
eTFvOQB/TN/M7G0uMdylMh5/xs1p02OolX8C7+0uM2uaWT7RnoNJfAYzXETrL7Bn
ksheGFgxWAaJcXYhI8mg4hQ3YhH3VKHxTiAU4YlN2zvoLQSy6qpNV755hBoTZucI
aSqwYaGePsZnHSOo3c+DcP70A2wKBFH7y/mPo+7yulnzwWWifbLy5U4uJyCkA3Qq
BYgoOtBQzy8AIPt849poxARnVtQQVTX85iOY5x02blREVMidCoFmeLARR2m4jROT
Z4mFVuE4X3amELLUfE3Ux0XyQfBry/oAtwMYpQQ0W72WjnSGnfRNjar8lAIyWW1Q
ghf/Lri5G/aUTC2AZceA8ktYx7vdF0bp/j+NfIuVgzRbcobJcwtKGeXzCZTi5ypy
ecsSXFTl
=X+U8
-----END PGP SIGNATURE-----

--ul3wunote6v2asse--
